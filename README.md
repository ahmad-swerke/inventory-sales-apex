# Inventory and Sales (Oracle APEX)

A small inventory and sales management application built with Oracle APEX as a hands-on learning project. It manages products, customers and orders, and keeps stock levels up to date automatically.

## Features

- **Products and categories**: manage products with price, stock quantity and reorder level
- **Customers**: customer list and form
- **Orders (Master-Detail)**: an order with its items in an editable Interactive Grid
- **Automatic stock handling** (database triggers):
  - unit price is filled from the product when not entered
  - stock decreases when an order item is added
  - stock is adjusted when an item is changed and restored when it is deleted
- **Dashboard**: KPI cards (sales this month, open orders, low stock items, customers), a low stock alert, and charts (top products, monthly sales)
- **Product catalog**: cards with Faceted Search (category, stock status, price range)
- **Sales report** based on order totals
- **Role-based security**: Reader, Contributor and Administrator
  - Reader: view only
  - Contributor: add and update orders
  - Administrator: full access, including delete and product management

## Database objects

| Type | Names |
|---|---|
| Tables | `product_categories`, `products`, `customers`, `orders`, `order_items` |
| Triggers | `order_items_price_trg`, `order_items_stock_trg` |
| Views | `products_v`, `order_totals_v` |

Constraints used: primary keys (identity columns), foreign keys, `CHECK` constraints (`price > 0`, `stock_qty >= 0`, `quantity > 0`) and `ON DELETE CASCADE` on order items.

## Repository structure

```
inventory-sales-apex/
├── README.md
├── sql/
│   ├── 01_tables.sql
│   ├── 02_triggers.sql
│   ├── 03_views.sql
│   └── 04_sample_data.sql
└── app/
    └── f18712.sql
```

## Installation

1. Open **SQL Workshop > SQL Commands** in your APEX workspace.
2. Run the scripts in `sql/` **in order**: `01`, `02`, `03`, then `04`. (Tables first, because triggers and views depend on them.)
3. Go to **App Builder > Import** and upload `app/f18712.sql`.
4. Run the application and sign in.
5. To use the roles, open **Administration > Access Control** and assign users as Reader, Contributor or Administrator.

## How the stock logic works

| Action on an order item | Effect on `products.stock_qty` |
|---|---|
| Insert | decreased by the quantity |
| Update | old quantity restored, new quantity subtracted |
| Delete | quantity restored |

The `CHECK (stock_qty >= 0)` constraint prevents selling more than what is in stock.

## Known limitations

- No protection yet against two users selling the last item at the same time (planned: `SELECT ... FOR UPDATE`).
- Changing an order status to Cancelled does not restore stock yet.
- Built and tested on a free apex.oracle.com workspace, not a production environment.

## What I learned

- Designing a relational schema with constraints
- Writing row-level triggers (`BEFORE` and `AFTER`, `:NEW` and `:OLD`)
- Using views to keep logic in one place
- Building Master-Detail pages, Faceted Search, charts and dashboards in APEX
- Authorization schemes, Access Control and Edit Authorization
- Debugging with exact error messages, data checks and the browser console

## Author

Ahmad
