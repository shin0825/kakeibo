# kakeibo web application

## 1. table

**wallets** `MASTER`

| name       | type     |
| ---------- | -------- |
| id         | integer  |
| name       | text     |
| created_at | datetime |
| updated_at | datetime |
|            |          |

<br>

**income_reasons** `MASTER`

| name       | type     |
| ---------- | -------- |
| id         | integer  |
| name       | text     |
| created_at | datetime |
| updated_at | datetime |
|            |          |

<br>

**spend_reasons** `MASTER`

| name       | type     |
| ---------- | -------- |
| id         | integer  |
| name       | text     |
| created_at | datetime |
| updated_at | datetime |
|            |          |

<br>

**spends** `TRANSACTION`

| name            | type     |
| --------------- | -------- |
| id              | integer  |
| amount          | money    |
| wallet_id       | integer  |
| spend_reason_id | integer  |
| user_id         | integer  |
| created_at      | datetime |
| updated_at      | datetime |
|                 |          |

<br>

**incomes** `TRANSACTION`

| name             | type     |
| ---------------- | -------- |
| id               | integer  |
| amount           | money    |
| wallet_id        | integer  |
| income_reason_id | integer  |
| user_id          | integer  |
| created_at       | datetime |
| updated_at       | datetime |
|                  |          |

<br>

**users** `MASTER`

| name              | type     |
| ----------------- | -------- |
| id                | integer  |
| name              | text     |
| email             | text     |
| created_at        | datetime |
| updated_at        | datetime |
| password_digest   | text     |
| remember_digest   | text     |
| admin             | boolean  |
| activation_digest | text     |
| activated         | boolean  |
| activated_at      | datetime |
| reset_digest      | text     |
| reset_sent_at     | datetime |
|                   |          |

<br>

## 2. design
- `各resourceに対応したCRUD`（usersは未対応）

- `transfers`（財布間移動）：`各reason_id`をシステム値`999(振替)`にして、出費収入処理を行う<br>
```rb
spend(amount: `振替額`, wallet_id: `振替先wallet_id`, spend_reason_id: `999`)<br>
income(amount: `振替額`, wallet_id: `振替もとwallet_id`, income_reason_id: `999`)
```
