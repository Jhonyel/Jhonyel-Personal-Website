# Frontend - Personal Portfolio Website

React-based frontend application built with Vite, TypeScript, and Material-UI.

## 🚀 Quick Start

```bash
# Install dependencies (from root)
yarn install

# Start development server
yarn dev

# Build for production
yarn build

# Preview production build
yarn preview

# Run linter
yarn lint
```

## 🏗️ Tech Stack

- **React 18.3** - UI library
- **TypeScript 5.2** - Type safety
- **Vite 5.3** - Build tool & dev server
- **Material-UI (MUI) 5.x** - Component library
- **React Query 3.39** - Server state management
- **React Router DOM 5.x** - Routing
- **React Hook Form 7.x** - Form handling
- **Yup** - Schema validation
- **Axios** - HTTP client

## 📁 Project Structure

```
src/
├── apis/              # API client functions
│   ├── experiences.api.ts
│   ├── projects.api.ts
│   └── users.api.ts
├── app/               # App setup & context providers
│   ├── App.tsx
│   ├── AppAuthenticated.tsx
│   ├── AppContextAuth.tsx
│   ├── AppContextQuery.tsx
│   ├── AppContextUser.tsx
│   └── AppPublic.tsx
├── components/        # Reusable components
│   ├── ErrorPage.tsx
│   ├── ExperienceCard.tsx
│   ├── Footer.tsx
│   ├── FormModal.tsx
│   ├── LoadingIndicator.tsx
│   ├── ProjectCard.tsx
│   └── TopNavBar.tsx
├── hooks/             # Custom React hooks
│   ├── auth.hooks.ts
│   ├── experiences.hooks.ts
│   ├── projects.hooks.ts
│   └── users.hooks.ts
├── pages/             # Page components
│   ├── ExperiencePage/
│   ├── HomePage/
│   ├── LoginPage/
│   └── ProjectPage/
├── transformers/      # Data transformers
├── utils/             # Utility functions
│   ├── auth.ts
│   ├── axios.ts
│   ├── dateUtils.ts
│   ├── routes.ts
│   ├── theme.ts
│   └── urls.ts
├── index.css          # Global styles
└── main.tsx           # Entry point
```

## 🔧 Configuration

### Environment Variables

Create `.env` in `src/frontend/`:

```env
VITE_API_URL=http://localhost:4001
```

### Available Scripts

- `yarn dev` - Start dev server on http://localhost:4000
- `yarn build` - Build for production to `dist/`
- `yarn preview` - Preview production build
- `yarn lint` - Run ESLint

## 🎨 Styling

This project uses:
- **Material-UI** for components
- **Emotion** for CSS-in-JS
- **Custom theme** defined in `utils/theme.ts`

### Custom Theme

```typescript
import { createTheme } from '@mui/material';

const theme = createTheme({
  palette: {
    primary: {
      main: '#your-color',
    },
    // ... more config
  },
});
```

## 🔌 API Integration

### React Query Setup

All API calls use React Query for caching and state management:

```typescript
// hooks/projects.hooks.ts
export const useGetAllProjects = () => {
  return useQuery(['projects'], getAllProjects);
};
```

### API Base URL

Configured in `utils/urls.ts`:

```typescript
const BASE_URL = import.meta.env.VITE_API_URL || "http://localhost:4001";
```

## 🛣️ Routing

Routes defined in `utils/routes.ts`:

```typescript
export const routes = {
  HOME: '/',
  PROJECTS: '/projects',
  EXPERIENCES: '/experiences',
  LOGIN: '/login',
};
```

## 🔐 Authentication

- Cookie-based authentication
- Dev mode: Uses `localStorage` for user ID
- Production: Uses HTTP-only cookies

## 📦 Building for Production

```bash
# Build
yarn build

# Output in dist/ directory
# Can be deployed to Vercel, Netlify, etc.
```

## 🎯 Development Tips

### Hot Module Replacement (HMR)

Vite provides instant HMR. Changes appear immediately without full page reload.

### Type Checking

```bash
# Type check without emitting files
tsc --noEmit
```

### ESLint Configuration

Configured in `eslint.config.js` with TypeScript support.

## 🐛 Common Issues

**Port 4000 already in use:**
```bash
# Change port in vite.config.ts
server: {
  port: 4001,
}
```

**Module not found:**
```bash
# Clear node_modules and reinstall
rm -rf node_modules
yarn install
```

**Build errors:**
```bash
# Clear Vite cache
rm -rf node_modules/.vite
yarn dev
```

## 📚 Learn More

- [React Documentation](https://reactjs.org/)
- [Vite Documentation](https://vitejs.dev/)
- [Material-UI Documentation](https://mui.com/)
- [React Query Documentation](https://tanstack.com/query/v3/)
- [TypeScript Documentation](https://www.typescriptlang.org/)

---

For full project documentation, see the [main README](../../README.md).
