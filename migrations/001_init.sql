CREATE TABLE IF NOT EXISTS transfers (
    id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    from_account VARCHAR(64) NOT NULL,
    to_account   VARCHAR(64) NOT NULL,
    amount       NUMERIC(19, 4) NOT NULL,
    currency     CHAR(3)     NOT NULL,
    status       VARCHAR(20) NOT NULL DEFAULT 'pending',
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_transfers_from_account ON transfers(from_account);
CREATE INDEX IF NOT EXISTS idx_transfers_to_account   ON transfers(to_account);
CREATE INDEX IF NOT EXISTS idx_transfers_status       ON transfers(status);
