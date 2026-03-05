# Dealership App

## Run with Docker (Team Setup)

### 1. Build and start
```bash
docker compose up --build
```

### 2. Open the app
`http://localhost:3000`

### 3. Stop
```bash
docker compose down
```

### Notes
- Uses SQLite inside the project (`storage/development.sqlite3`).
- `db:prepare` runs automatically on container start.
- First startup may take a few minutes while gems install.
