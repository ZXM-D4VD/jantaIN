-- JANSEVA PRODUCTION DATABASE SCHEMA

-- 1. CAMPAIGN TABLE
CREATE TABLE IF NOT EXISTS public.js_campaigns (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    category TEXT NOT NULL,
    city TEXT NOT NULL,
    goal NUMERIC NOT NULL,
    raised NUMERIC DEFAULT 0,
    image TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. EMERGENCY REQUESTS TABLE
CREATE TABLE IF NOT EXISTS public.js_requests (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT NOT NULL,
    city TEXT NOT NULL,
    category TEXT NOT NULL,
    concern TEXT NOT NULL,
    status TEXT DEFAULT 'Pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. REGISTERED USERS TABLE
CREATE TABLE IF NOT EXISTS public.js_users (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- SEED INITIAL DATA
INSERT INTO public.js_campaigns (id, title, category, city, goal, raised, image)
VALUES 
('C1', 'Child Education & Digital Literacy Drive', 'Education', 'New Delhi', 500000, 385000, 'https://images.unsplash.com/photo-1509062522246-3755977927d7?auto=format&fit=crop&w=600&q=80'),
('C2', 'Daily Meal Ration for Wagers', 'Food Relief', 'Mumbai', 800000, 620000, 'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?auto=format&fit=crop&w=600&q=80')
ON CONFLICT (id) DO NOTHING;
