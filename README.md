# kakeibo web application

## 1. table architecture

- 基本概念<br>
  wallet -> `has_many` -> spend<br>
  wallet -> `has_many` -> income<br>
  spend summary is "支出"<br>
  income summary is "収入"<br>
  <br>

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

## 2. design architecture

- "`spends` or `incomes` amount input"で計算機が表示されていると嬉しい
- `user` login<br>
  -> `spends` or `incomes` or `transfers` or `summary` choice<br>
  -> `wallets` choice if choice==(`spends` or `incomes`)<br>
  ->-> `reasons` choice<br>
  ->-> `spends` or `incomes` amount input<br>
  ->-> send commit!<br>
  -> get `summary` page if choice==(`summary`)<br>

- SPA で実装する
- `transfers`を選択した場合は、`各reason_id`をシステム値`999(振替)`にして、下記の処理を行う<br>

```rb
spend(amount: `振替額`, wallet_id: `振替先wallet_id`, spend_reason_id: `999`)<br>
income(amount: `振替額`, wallet_id: `振替もとwallet_id`, income_reason_id: `999`)
```
