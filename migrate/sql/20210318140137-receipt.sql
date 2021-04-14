/*
 * Copyright 2020 The Nakama Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

-- +migrate Up
ALTER TABLE purchase_receipt
    DROP CONSTRAINT IF EXISTS purchase_receipt_pkey, -- Drop primary key constraint for Postgres
    DROP CONSTRAINT IF EXISTS "primary",             -- Drop primary key constraint for Cockroach
    ADD CONSTRAINT purchase_receipt_pkey PRIMARY KEY (transaction_id);

-- +migrate Down
ALTER TABLE purchase_receipt
    ADD COLUMN IF NOT EXISTS receipt TEXT NOT NULL CHECK (length(receipt) > 0),
    DROP CONSTRAINT purchase_receipt_pkey,
    ADD CONSTRAINT purchase_receipt_pkey PRIMARY KEY (receipt);