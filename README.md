# NEWRA GES–IPP Comparator

NEWRA is a renewable-energy procurement workspace for matching a Group of Energy
Users (GES) with Independent Power Producers (IPPs). The web app manages the
procurement workflow; the API evaluates supplier data and persists the results
in PostgreSQL. Seeded figures and demo accounts are for local development only.

## Project structure

This repository uses an `apps/` monorepo layout to keep the frontend and backend
separate while sharing root-level development commands:

```text
apps/
  backend/   NestJS API, Prisma schema/seed, domain calculations and API tests
  frontend/  Next.js frontend, pages, feature components and web tests
docs/        Supporting product and page/component documentation
docker-compose.yml
package.json
```

## Current functionality

- Role-based sign-in and access control, including GES-scoped consumer accounts.
- Dashboard and management of GES profiles, renewable-energy requirements and
  IPP supplier records/catalogues.
- IPP evaluation, GES suitability, 15-minute load matching, tariff scenarios,
  commercial and technical inputs, critical gates and red-flag reviews.
- Comparison, shortlisting, supplier negotiations/offers, procurement documents,
  PSOA and dealbook workflows.
- PDF/XLSX exports for comparison and PDF dealbook export.
- PostgreSQL persistence, audit events, API request validation and health check.

Evaluation and comparison calculations are performed by the API; the frontend
renders the API's results.

## Technology

- **Frontend:** Next.js 14, React 18, TypeScript, TanStack Query, Recharts.
- **Backend:** NestJS 10, TypeScript, Prisma 5.
- **Database:** PostgreSQL 16.
- **Testing:** Jest and Testing Library.

## Requirements

- Node.js and npm (use a current Node.js LTS release).
- Docker Desktop with Docker Compose, or a compatible PostgreSQL 16 instance.

## Local development

Run the following commands from the repository root in PowerShell.

1. Install the separate frontend and backend dependencies:

   ```powershell
   npm install --prefix apps/backend
   npm install --prefix apps/frontend
   ```

2. Configure the backend environment and start PostgreSQL:

   ```powershell
   Copy-Item apps/backend/.env.example apps/backend/.env
   docker compose up -d postgres
   ```

   The example configuration targets the local Compose database on port `5435`.
   Replace the example JWT secrets in `apps/backend/.env` with long, random values.
   Never use the example secrets or demo accounts outside local development.

3. Generate the Prisma client, create/update the database schema and seed demo
   data:

   ```powershell
   npm run prisma:generate --prefix apps/backend
   npm run db:migrate
   npm run db:seed
   ```

4. Start the API and frontend in two PowerShell terminals:

   ```powershell
   npm run dev:api
   ```

   ```powershell
   npm run dev:web
   ```

   Open [http://localhost:3010](http://localhost:3010). The API is available at
   `http://localhost:4010/api`; its health endpoint is
   `http://localhost:4010/api/health`.

The frontend defaults to the local API URL. To use another API address, set
`NEXT_PUBLIC_API_URL` in `apps/frontend/.env.local` (include the `/api` path).

## Demo accounts

The seed script creates local demo users. The shared demo password is
`NewraDemo#2026`; it must only be used with the local seeded database.

Platform users include `admin@newra.demo`, `evaluator@newra.demo`,
`commercial@newra.demo`, `technical@newra.demo`, `finance@newra.demo` and
`viewer@newra.demo`. GES-scoped accounts are:

- `ges.aster@newra.demo` — Aster Manufacturing Group
- `ges.nova@newra.demo` — Nova Industrial Works
- `ges.vertex@newra.demo` — Vertex Metals & Engineering
- `ges.helix@newra.demo` — Helix Chemicals

## Useful commands

Run from the repository root:

| Command | Purpose |
| --- | --- |
| `npm run db:up` | Start the PostgreSQL Compose service |
| `npm run db:migrate` | Apply Prisma development migrations |
| `npm run db:seed` | Seed local demo data |
| `npm run dev:api` | Start the NestJS API in watch mode |
| `npm run dev:web` | Start the Next.js frontend |
| `npm run build:api` | Build the API |
| `npm run build:web` | Build the frontend |
| `npm test` | Run API and frontend test suites |
| `npm run test:api` | Run API tests |
| `npm run test:web` | Run frontend tests |

## Data and security notes

- All seeded profiles, load curves, tariffs and account credentials are
  illustrative demo data.
- The Compose database credentials are development defaults, not production
  secrets. Use managed secrets, secure database credentials, and appropriate
  deployment configuration for hosted environments.
- The API uses access and refresh tokens, permission and GES-scope guards, input
  validation, CORS configuration and HTTP security headers.
- Do not commit `.env` or `.env.local` files.
