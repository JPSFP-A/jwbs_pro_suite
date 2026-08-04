-- Migration 011: Close anon PIN-dump hole
-- get_portal_pins() returned every role's plaintext PIN to any caller holding
-- the public anon key (shipped client-side in public/js/config.js). No login
-- required. Revoke + drop it; nothing in the app legitimately needs to list
-- all PINs from the client. validate_*_pin() are left anon-callable since
-- they only check a caller-supplied guess and don't disclose stored values.

revoke execute on function get_portal_pins() from anon;
drop function if exists get_portal_pins();
