# Security

## Authentication and sessions

- passwords use `password_hash()` / `password_verify()`;
- login throttling is persisted in `auth_login_throttle`;
- session ID is regenerated on authentication;
- strict-mode cookie sessions use HttpOnly and SameSite=Lax; Secure is enabled under HTTPS;
- session data is stored server-side in the database.

## Authorization and CSRF

- mutations require authenticated users and CSRF validation;
- admin actions require `requireAdmin()`;
- user-specific Repository queries include user ownership constraints;
- `admin/db-check.php` is admin-only and exposes no connection password/secret or arbitrary SQL execution.

## SQL/XSS/error handling

- PDO native prepared statements are used for parameterized user input;
- frontend output passes through escaping helpers before insertion in HTML;
- unexpected server exceptions are logged and returned as generic service errors rather than raw credentials/stack traces.

## Import/archive security

DOCX/XLSX ZIP parsing enforces compressed/uncompressed entry limits, entry count, compression-ratio limits, XML limits and path-traversal checks. Spreadsheet/import limits also cap rows/columns/items. This addresses decompression/ZIP bombs rather than relying only on PHP upload size.

## Content/database lifecycle

- schema migrations and content seeds are checksum tracked separately;
- content seed execution is wrapped in a transaction so a DML failure does not leave an untracked partial seed;
- no content seed contains schema DDL;
- Aptis fidelity upgrades retire rows rather than deleting attempt history.

## PWA/privacy

- service worker does not handle/cache `api.php` responses;
- non-GET requests are not intercepted;
- Speaking recording remains local in the browser unless a future explicit upload feature is implemented;
- Writing drafts remain in localStorage keyed by user+task and are removed after successful submission.

## Release hygiene

The final build is scanned for real Gmail addresses, `config.local.php`, `.env`, logs, caches, node_modules, nested ZIPs and credential-like assignments. Security-test files may contain the literal words “secret/password/token” as audit patterns; those are not credentials.

## Remaining limitations

A security audit is not a penetration test. Deployment still requires HTTPS, strong admin credentials, least-privilege DB credentials, regular backups and supported PHP/MariaDB versions.
