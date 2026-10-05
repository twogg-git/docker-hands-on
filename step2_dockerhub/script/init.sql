CREATE TABLE IF NOT EXISTS internsdb (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO internsdb (name, email) VALUES 
('Alice Smith', 'alice@company.com'),
('Bob Jones', 'bob@company.com');
