CREATE TABLE IF NOT EXISTS auth_login_throttle (
    throttle_key CHAR(64) NOT NULL,
    failures INT NOT NULL DEFAULT 0,
    first_failure_at DATETIME NULL,
    last_failure_at DATETIME NULL,
    locked_until DATETIME NULL,
    PRIMARY KEY (throttle_key),
    KEY idx_auth_lock (locked_until),
    KEY idx_auth_last_failure (last_failure_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
