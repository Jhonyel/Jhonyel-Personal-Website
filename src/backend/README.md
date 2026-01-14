# Backend API - Personal Portfolio Website

Express.js RESTful API built with TypeScript, Prisma ORM, and PostgreSQL.

## 🚀 Quick Start

```bash
# Install dependencies (from root)
yarn install

# Generate Prisma Client
yarn prisma:generate

# Run migrations
yarn prisma:migrate

# Seed database
yarn prisma:seed

# Start development server
yarn dev

# Run tests
yarn test
```

## 🏗️ Tech Stack

- **Node.js** - Runtime environment
- **Express 4.17** - Web framework
- **TypeScript 4.x** - Type safety
- **Prisma 5.15** - ORM
- **PostgreSQL** - Database
- **Express Validator** - Request validation
- **Multer** - File upload handling
- **CORS** - Cross-origin resource sharing
- **Vitest** - Testing framework

## 📁 Project Structure

```
src/
├── controllers/           # Request handlers
│   ├── experiences.controller.ts
│   ├── projects.controller.ts
│   └── user.controller.ts
├── prisma/               # Database
│   ├── migrations/       # Database migrations
│   ├── schema.prisma     # Database schema
│   ├── prisma.ts         # Prisma client
│   └── seed.ts           # Database seeding
├── prisma-query-args/    # Reusable Prisma queries
│   ├── experience.query-args.ts
│   ├── project.query-args.ts
│   └── user-query-args.ts
├── routes/               # Route definitions
│   ├── experiences.routes.ts
│   ├── projects.routes.ts
│   └── user.routes.ts
├── services/             # Business logic
│   ├── experiences.services.ts
│   ├── projects.services.ts
│   └── user.services.ts
├── transformers/         # Data transformation
│   ├── experience.transformer.ts
│   ├── project.transformer.ts
│   └── user.transformer.ts
└── utils/                # Utilities
    ├── auth.utils.ts
    ├── error.utils.ts
    ├── file.utils.ts
    └── validation.utils.ts
tests/                    # Test files
uploads/                  # Uploaded files
index.ts                  # Entry point
```

## 🗄️ Database

### Schema Location

`src/prisma/schema.prisma`

### Prisma Commands

```bash
# Generate Prisma Client (after schema changes)
npx prisma generate

# Create migration
npx prisma migrate dev --name migration_name

# Apply migrations (production)
npx prisma migrate deploy

# Seed database
npx prisma db seed

# Reset database (caution!)
npx prisma migrate reset

# Open Prisma Studio (database GUI)
npx prisma studio
```

### Database Models

- **User** - User profiles with authentication
- **Project** - Portfolio projects
- **Experience** - Work experiences

### Relations

```
User
├── createdProjects (Project[])
├── deletedProjects (Project[])
├── createdExperiences (Experience[])
└── deletedExperiences (Experience[])
```

## 🔧 Configuration

### Environment Variables

Create `.env` in `src/backend/`:

```env
DATABASE_URL="postgresql://postgres:docker@localhost:8000/nerpm?schema=public"
PORT=4001
NODE_ENV=development
```

### Available Scripts

- `yarn dev` - Start dev server with hot reload (nodemon)
- `yarn build` - Compile TypeScript to JavaScript
- `yarn start` - Start production server
- `yarn test` - Run tests with Vitest

## 📡 API Endpoints

### Base URL

```
http://localhost:4001
```

### Projects

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| GET | `/projects` | Get all projects | No |
| POST | `/projects/new` | Create project | Admin |
| POST | `/projects/:id/update` | Update project | Admin |
| DELETE | `/projects/:id` | Delete project | Admin |

### Experiences

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| GET | `/experiences` | Get all experiences | No |
| POST | `/experiences/new` | Create experience | Admin |
| POST | `/experiences/:id/update` | Update experience | Admin |
| DELETE | `/experiences/:id` | Delete experience | Admin |

### Users

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| GET | `/users/:id` | Get user profile | No |
| POST | `/users/auth/login` | Login | No |

### File Uploads

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/uploads/:filename` | Get uploaded file |

## 🔐 Authentication

### Development Mode

Uses `Authorization` header with user ID:

```typescript
headers: {
  Authorization: 'user-uuid-here'
}
```

### Production Mode

Uses HTTP-only cookies set after login.

### Middleware

```typescript
// src/utils/auth.utils.ts
export const requireAuthorization = (req, res, next) => {
  // Authentication logic
};
```

## 🎯 Architecture Patterns

### Controller → Service → Prisma

```typescript
// Controller - Handle HTTP request/response
export const getProjects = async (req, res) => {
  const projects = await projectsService.getAllProjects();
  res.json(projects);
};

// Service - Business logic
export const getAllProjects = async () => {
  return await prisma.project.findMany(projectQueryArgs);
};

// Query Args - Reusable queries
export const projectQueryArgs = {
  where: { deletedAt: null },
  include: { creator: true },
};
```

### Transformers

Convert database models to API responses:

```typescript
// Input: Prisma model
const dbProject = { id: '1', title: 'Test', creator: {...} };

// Output: API response
const apiProject = transformProject(dbProject);
// { id: '1', title: 'Test', creatorId: '...', creatorName: '...' }
```

## 🧪 Testing

### Running Tests

```bash
# Run all tests
yarn test

# Run in watch mode
yarn test --watch

# Run with coverage
yarn test --coverage
```

### Test Structure

```typescript
import { describe, it, expect, beforeEach } from 'vitest';

describe('Projects API', () => {
  beforeEach(async () => {
    // Setup test database
  });

  it('should get all projects', async () => {
    const response = await request(app).get('/projects');
    expect(response.status).toBe(200);
    expect(response.body).toHaveLength(5);
  });
});
```

### Test Database

Tests use a separate database (port 8001):

```bash
# Setup test database
yarn test:setup

# Teardown test database
yarn test:teardown
```

## 📝 Request Validation

Using Express Validator:

```typescript
import { body, validationResult } from 'express-validator';

const createProjectValidation = [
  body('title').notEmpty().withMessage('Title is required'),
  body('description').notEmpty(),
  body('githubUrl').isURL(),
];

router.post('/new', createProjectValidation, async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  // Handle request
});
```

## 📤 File Uploads

Using Multer middleware:

```typescript
import multer from 'multer';

const upload = multer({
  dest: 'uploads/',
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB
  fileFilter: (req, file, cb) => {
    if (file.mimetype.startsWith('image/')) {
      cb(null, true);
    } else {
      cb(new Error('Only images allowed'));
    }
  },
});

router.post('/upload', upload.single('image'), handler);
```

## 🔄 CORS Configuration

```typescript
const options: cors.CorsOptions = {
  origin: ["http://localhost:4000", "http://127.0.0.1:4000"],
  credentials: true,
  methods: "GET, POST, DELETE",
};

app.use(cors(options));
```

## 🐛 Error Handling

Centralized error handler:

```typescript
// utils/error.utils.ts
export const errorHandler = (err, req, res, next) => {
  console.error(err);
  res.status(err.status || 500).json({
    message: err.message || 'Internal Server Error',
  });
};

app.use(errorHandler);
```

## 📊 Database Seeding

Edit `src/prisma/seed.ts` to add initial data:

```typescript
const seedProjects = async () => {
  await prisma.project.createMany({
    data: [
      { title: 'Project 1', ... },
      { title: 'Project 2', ... },
    ],
  });
};
```

## 🚀 Production Build

```bash
# Build TypeScript
yarn build

# Output in dist/ directory
# Run with: node dist/backend/index.js
```

## 🔍 Debugging

### Prisma Query Logging

```typescript
// prisma.ts
const prisma = new PrismaClient({
  log: ['query', 'info', 'warn', 'error'],
});
```

### VS Code Launch Configuration

```json
{
  "type": "node",
  "request": "launch",
  "name": "Debug Backend",
  "program": "${workspaceFolder}/src/backend/index.ts",
  "preLaunchTask": "tsc: build",
  "outFiles": ["${workspaceFolder}/dist/**/*.js"]
}
```

## 📚 Learn More

- [Express Documentation](https://expressjs.com/)
- [Prisma Documentation](https://www.prisma.io/docs/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [TypeScript Documentation](https://www.typescriptlang.org/)

---

For full project documentation, see the [main README](../../README.md).
