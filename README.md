# Personal Portfolio Website

A full-stack personal portfolio website built with React, Express, and PostgreSQL. Showcase your projects, work experiences, and professional profile in a clean, modern interface.

## Documentation

For detailed documentation, see:
- **[Backend Documentation](src/backend/README.md)** - API endpoints, database schema, testing
- **[Frontend Documentation](src/frontend/README.md)** - React app structure, components, routing

## Quick Start

Get up and running in 5 minutes with Docker!

### 1. Prerequisites

```bash
node --version  # Need v20+
yarn --version  # Need v1.22+
docker --version
```

### 2. Clone & Install

```bash
git clone <your-repo-url>
cd Jhonyel-Personal-Website
yarn install
```

### 3. Start Database

```bash
docker-compose up -d
```

### 4. Setup Database

```bash
yarn prisma:generate
yarn prisma:migrate
yarn prisma:seed
```

### 5. Start Application

```bash
yarn start
```

### 6. Open Browser

- **Frontend**: http://localhost:4000
- **Backend API**: http://localhost:4001

---

## Features

- **Project Management** - Create, edit, and showcase your development projects
- **Experience Tracking** - Document your work experience and career journey
- **User Profile** - Personal profile with bio, skills, and social links
- **Image Uploads** - Upload and display project screenshots and profile images
- **Authentication** - Secure login with role-based access control (Admin/Guest)
- **Responsive Design** - Mobile-first design with Material-UI components
- **Fast Performance** - Optimized with Vite for lightning-fast builds
- **Real-time Updates** - Automatic UI updates with React Query
- **Tested** - Backend API covered with Vitest unit tests

---

## Tech Stack

### Frontend
- React 18.3 with TypeScript
- Vite for build tooling
- Material-UI component library
- React Query for state management
- React Router for navigation

### Backend
- Node.js with Express
- TypeScript
- Prisma ORM
- PostgreSQL database
- Vitest for testing

### Development
- Yarn Workspaces monorepo
- Docker for database
- Concurrently for running multiple processes

---

## Project Structure

```
Jhonyel-Personal-Website/
├── src/
│   ├── frontend/         # React frontend application
│   │   ├── src/
│   │   │   ├── apis/    # API client functions
│   │   │   ├── app/     # App context providers
│   │   │   ├── components/  # Reusable components
│   │   │   ├── hooks/   # Custom React hooks
│   │   │   ├── pages/   # Page components
│   │   │   └── utils/   # Utility functions
│   │   └── README.md    # Frontend documentation
│   │
│   ├── backend/          # Express backend API
│   │   ├── src/
│   │   │   ├── controllers/  # Route controllers
│   │   │   ├── prisma/  # Database schema & migrations
│   │   │   ├── routes/  # API routes
│   │   │   ├── services/  # Business logic
│   │   │   └── utils/   # Utility functions
│   │   ├── tests/       # Backend tests
│   │   └── README.md    # Backend documentation
│   │
│   └── shared/           # Shared TypeScript types
│
├── scripts/              # Utility scripts
├── docker-compose.yml    # Docker configuration
├── package.json          # Root package.json
└── README.md
```

---

## Available Scripts

### Development

| Command                | Description                     |
| ---------------------- | ------------------------------- |
| `yarn start`           | Start both frontend and backend |
| `yarn backend:dev`     | Start backend only              |
| `yarn frontend:dev`    | Start frontend only             |

### Database

| Command                | Description                     |
| ---------------------- | ------------------------------- |
| `yarn prisma:generate` | Generate Prisma Client          |
| `yarn prisma:migrate`  | Run database migrations         |
| `yarn prisma:seed`     | Seed database with sample data  |
| `yarn prisma:reset`    | Reset database and re-seed      |

### Testing

| Command             | Description        |
| ------------------- | ------------------ |
| `yarn test:backend` | Run backend tests  |

### Building

```bash
# Frontend
cd src/frontend && yarn build

# Backend
cd src/backend && yarn build
```

---

## Environment Variables

### Docker Setup (Recommended)

When using `docker-compose up -d`, environment variables are configured automatically.

### Manual Setup

If not using Docker, create these files:

**Backend** (`src/backend/.env`):
```env
DATABASE_URL="postgresql://postgres:YOUR_PASSWORD@localhost:5432/nerpm?schema=public"
PORT=4001
NODE_ENV=development
```

**Frontend** (`src/frontend/.env`) - Optional:
```env
VITE_API_URL=http://localhost:4001
```

---

## Docker Commands

```bash
# Start database
docker-compose up -d

# Stop database
docker-compose down

# Stop and remove all data
docker-compose down -v

# View logs
docker-compose logs -f

# Access PostgreSQL shell
docker exec -it launchpad psql -U postgres -d nerpm
```

---

## Troubleshooting

### Database Won't Start

```bash
docker-compose down -v
docker-compose up -d
```

### Port Already in Use

**Windows:**
```bash
netstat -ano | findstr :4000
taskkill /PID <PID> /F
```

**macOS/Linux:**
```bash
lsof -ti:4000 | xargs kill
```

### Prisma Errors

```bash
yarn prisma:generate
yarn prisma:migrate
```

### Database Issues

```bash
docker ps                      # Check if running
docker-compose restart         # Restart
yarn prisma:reset             # Reset database
```

### Module/Build Errors

```bash
rm -rf node_modules
yarn install
yarn prisma:generate
```

---

## Production Deployment

### Frontend Build

```bash
cd src/frontend
yarn install
yarn build
# Output in dist/ directory
```

### Backend Build

```bash
cd src/backend
yarn install
npx prisma generate
yarn build
# Output in dist/ directory
```

### Environment Variables

Set these for production:
- `DATABASE_URL` - Your production database URL
- `FRONTEND_URL` - Your frontend domain (for CORS)
- `VITE_API_URL` - Your backend API URL

---

Made by Jhonyel Galvis
