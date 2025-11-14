# Cafe Keeper Server

Express.js backend server for the Cafe Keeper application - a comprehensive cafe management system.

## 🚀 Features

- RESTful API built with Express.js
- PostgreSQL database integration
- User authentication and authorization
- Order management
- Menu and inventory management
- Real-time updates

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- [Node.js](https://nodejs.org/) (v14 or higher)
- [PostgreSQL](https://www.postgresql.org/) (v12 or higher)
- [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/)

## 🛠️ Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/cafe-keeper/cafe-keeper-server.git
   cd cafe-keeper-server
   ```

2. **Install dependencies**

   ```bash
   npm install
   ```

3. **Set up environment variables**

   Create a `.env` file in the root directory:

   ```env
   # Server Configuration
   PORT=3000
   NODE_ENV=development

   # Database Configuration
   DB_USER=your_postgres_username
   DB_HOST=localhost
   DB_NAME=cafe_keeper
   DB_PASSWORD=your_password
   DB_PORT=5432

   # JWT Secret (for authentication)
   JWT_SECRET=your_jwt_secret_key_here

   # Optional: CORS Configuration
   CORS_ORIGIN=http://localhost:3001
   ```

4. **Set up the PostgreSQL database**

   Create the database:

   ```bash
   createdb cafe_keeper
   ```

   Or using psql:

   ```sql
   psql postgres
   CREATE DATABASE cafe_keeper;
   \q
   ```

5. **Run database migrations** (if applicable)

   ```bash
   npm run migrate
   ```

## 🚀 Running the Server

### Development Mode

```bash
npm run dev
```

### Production Mode

```bash
npm start
```

The server will start on `http://localhost:3000` (or the port specified in your `.env` file).

## 📁 Project Structure

```
cafe-keeper-server/
├── src/
│   ├── config/          # Configuration files (database, etc.)
│   ├── controllers/     # Route controllers
│   ├── models/          # Database models
│   ├── routes/          # API routes
│   ├── middleware/      # Custom middleware (auth, validation, etc.)
│   ├── utils/           # Utility functions
│   └── app.js           # Express app setup
├── tests/               # Test files
├── .env                 # Environment variables (not in repo)
├── .gitignore
├── package.json
└── README.md
```

## 🔌 API Endpoints

### Authentication

- `POST /api/auth/register` - Register a new user
- `POST /api/auth/login` - Login user
- `POST /api/auth/logout` - Logout user

### Users

- `GET /api/users` - Get all users (admin only)
- `GET /api/users/:id` - Get user by ID
- `PUT /api/users/:id` - Update user
- `DELETE /api/users/:id` - Delete user

### Menu Items

- `GET /api/menu` - Get all menu items
- `GET /api/menu/:id` - Get menu item by ID
- `POST /api/menu` - Create new menu item (admin only)
- `PUT /api/menu/:id` - Update menu item (admin only)
- `DELETE /api/menu/:id` - Delete menu item (admin only)

### Orders

- `GET /api/orders` - Get all orders
- `GET /api/orders/:id` - Get order by ID
- `POST /api/orders` - Create new order
- `PUT /api/orders/:id` - Update order status
- `DELETE /api/orders/:id` - Cancel order

### Inventory

- `GET /api/inventory` - Get all inventory items
- `POST /api/inventory` - Add inventory item
- `PUT /api/inventory/:id` - Update inventory item
- `DELETE /api/inventory/:id` - Remove inventory item

## 🧪 Testing

```bash
# Run all tests
npm test

# Run tests with coverage
npm run test:coverage

# Run tests in watch mode
npm run test:watch
```

## 🗄️ Database Schema

### Users Table

```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(100) UNIQUE NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role VARCHAR(50) DEFAULT 'user',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Menu Items Table

```sql
CREATE TABLE menu_items (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,
  category VARCHAR(100),
  image_url VARCHAR(500),
  available BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Orders Table

```sql
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  total_amount DECIMAL(10, 2) NOT NULL,
  status VARCHAR(50) DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Order Items Table

```sql
CREATE TABLE order_items (
  id SERIAL PRIMARY KEY,
  order_id INTEGER REFERENCES orders(id) ON DELETE CASCADE,
  menu_item_id INTEGER REFERENCES menu_items(id),
  quantity INTEGER NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## 🔒 Security

- Passwords are hashed using bcrypt
- JWT tokens for authentication
- Input validation and sanitization
- SQL injection prevention using parameterized queries
- CORS configuration for frontend integration
- Rate limiting to prevent abuse

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 Environment Variables Reference

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `PORT` | Server port | 3000 | No |
| `NODE_ENV` | Environment (development/production) | development | No |
| `DB_USER` | PostgreSQL username | - | Yes |
| `DB_HOST` | PostgreSQL host | localhost | Yes |
| `DB_NAME` | Database name | - | Yes |
| `DB_PASSWORD` | Database password | - | Yes |
| `DB_PORT` | PostgreSQL port | 5432 | No |
| `JWT_SECRET` | Secret key for JWT | - | Yes |
| `CORS_ORIGIN` | Allowed CORS origin | * | No |

## 🐛 Troubleshooting

### Database Connection Issues

- Ensure PostgreSQL is running: `brew services list`
- Check database credentials in `.env`
- Verify database exists: `psql -l`

### Port Already in Use

- Change the `PORT` in `.env`
- Kill the process using the port: `lsof -ti:3000 | xargs kill`

### Module Not Found

- Delete `node_modules` and reinstall: `rm -rf node_modules && npm install`

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- Cafe Keeper Team - [GitHub Organization](https://github.com/cafe-keeper)

## 🙏 Acknowledgments

- Express.js community
- PostgreSQL community
- All contributors to this project

---

For more information or support, please open an issue on the [GitHub repository](https://github.com/cafe-keeper/cafe-keeper-server).
