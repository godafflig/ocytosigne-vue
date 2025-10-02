// @ts-nocheck
// Supabase Edge Function (Deno) - get_practitioner
// Retourne un praticien (par id) ou une liste paginée avec join sur profiles
// Appel côté client: supabase.functions.invoke('get_practitioner', { body: { id?, limit? } })

import { serve } from "https://deno.land/std@0.224.0/http/server.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2"

const corsHeaders = {
  "access-control-allow-origin": "*",
  "access-control-allow-methods": "GET, POST, OPTIONS",
  "access-control-allow-headers": "authorization, x-client-info, apikey, content-type"
}

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: {
      "content-type": "application/json; charset=utf-8",
      ...corsHeaders
    }
  })
}

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("", { headers: corsHeaders })
  }

  try {
    const SUPABASE_URL = Deno.env.get("SUPABASE_URL")
    const SERVICE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")

    if (!SUPABASE_URL || !SERVICE_KEY) {
      return json({ error: "Missing Supabase env vars (SUPABASE_URL / SUPABASE_SERVICE_ROLE_KEY)" }, 500)
    }

    // Utilise la clé service role côté serveur pour bypass RLS
    const supabase = createClient(SUPABASE_URL, SERVICE_KEY)

    const { id, limit = 20 } = await req.json().catch(() => ({})) as { id?: string; limit?: number }

    let query = supabase
      .from("practitioner")
      .select(
        "id,rating,address,specialty,services,formation,experience,consult_type,profiles(id,firstname,lastname,birthdate,com_mod,avatar_url,phone)"
      )
      .limit(Number(limit) || 20)

    if (id) {
      const { data, error } = await query.eq("id", id).maybeSingle()
      if (error) return json({ error: error.message }, 400)
      return json({ data })
    }

    const { data, error } = await query
    if (error) return json({ error: error.message }, 400)
    return json({ data })
  } catch (e) {
    const msg = e instanceof Error ? e.message : String(e)
    return json({ error: msg }, 500)
  }
})
