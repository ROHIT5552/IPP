# NewRa IPP Comparator

NewRa IPP Comparator is a local workspace for comparing independent power producers for a GES account. The website runs on your computer. The API scores the producers and stores the results in PostgreSQL.

## What you need

- [Node.js](https://nodejs.org) LTS (this project uses Node 20 or newer) and npm
- [Docker Desktop](https://www.docker.com/products/docker-desktop/), with Docker running before you start

Open PowerShell in this project folder for every command below.

## 1. Install the app

```powershell
npm install --prefix apps/backend
npm install --prefix apps/frontend
```

## 2. Create the backend settings file

```powershell
Copy-Item apps/backend/.env.example apps/backend/.env
```

The example file already points at the local database on port `5435`. You can leave it as it is for local use. Do not commit `.env`.

## 3. Start the database

```powershell
docker compose up -d postgres
```

Wait until Docker shows the Postgres container as healthy. The database name is `newra_comparator`. The local user and password are both `newra`.

## 4. Load the shared data

Use the dump when you want the same GES accounts, producers, questionnaire ratings, and tariff rounds that are already in this copy of the project.

```powershell
Get-Content -Raw .\apps\backend\prisma\newra-comparator.sql | docker exec -i newra-comparator-postgres psql -U newra -d newra_comparator
```

Then create the Prisma client the API needs:

```powershell
npm run prisma:generate --prefix apps/backend
```

Do not run `npm run db:seed` after this. The seed loads a different demo set and will not match the dump.

If you do not have the dump file and only want an empty demo database, use this instead of the restore command:

```powershell
npm run prisma:generate --prefix apps/backend
npm run db:migrate
npm run db:seed
```

## 5. Start the website and the API

Use two PowerShell windows. Leave both running.

```powershell
npm run dev:api
```

```powershell
npm run dev:web
```

Open [http://localhost:3010](http://localhost:3010).

The API runs at [http://localhost:4010/api](http://localhost:4010/api). A quick check is [http://localhost:4010/api/health](http://localhost:4010/api/health).

## Sign in

After the API starts, this local admin account is ready:

- Email: `admin@newragrids.com`
- Password: `nrg@2026`

The dump also includes the GES account `rohithiwrale5552@gmail.com` (Rohit H). Use the password that was set for that account. These logins are for this local database only.

## Other commands

| Command | What it does |
| --- | --- |
| `npm run db:up` | Start the database |
| `npm run dev:api` | Start the API |
| `npm run dev:web` | Start the website |
| `npm run build:api` | Build the API |
| `npm run build:web` | Build the website |
| `npm test` | Run the API and website tests |

## If something does not start

- Docker Desktop must be running before `docker compose up`.
- If port `3010` or `4010` is already in use, stop the other copy of the app and start it again.
- If the website cannot reach the API, check that the API window is still running.
- To point the website at a different API, create `apps/frontend/.env.local` and set `NEXT_PUBLIC_API_URL` to an address that ends with `/api`.
