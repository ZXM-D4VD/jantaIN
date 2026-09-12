-- 1. Requests Table (Help Requests & Submissions)
CREATE TABLE IF NOT EXISTS public.requests (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ticket_id VARCHAR(50) UNIQUE NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. Campaigns Table (Donation & Welfare Campaigns)
CREATE TABLE IF NOT EXISTS public.campaigns (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    target_amount NUMERIC(12, 2) NOT NULL,
    raised_amount NUMERIC(12, 2) DEFAULT 0,
    icon VARCHAR(100) DEFAULT 'fa-heart',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. Profiles Table (User / Admin Records)
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable Row Level Security (RLS) & Public Access Policies
ALTER TABLE public.requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.campaigns ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Allow Public Read/Write Access for Portal Operations
CREATE POLICY "Public Read Requests" ON public.requests FOR SELECT USING (true);
CREATE POLICY "Public Insert Requests" ON public.requests FOR INSERT WITH CHECK (true);
CREATE POLICY "Public Update Requests" ON public.requests FOR UPDATE USING (true);
CREATE POLICY "Public Delete Requests" ON public.requests FOR DELETE USING (true);

CREATE POLICY "Public Read Campaigns" ON public.campaigns FOR SELECT USING (true);
CREATE POLICY "Public Insert Campaigns" ON public.campaigns FOR INSERT WITH CHECK (true);
CREATE POLICY "Public Update Campaigns" ON public.campaigns FOR UPDATE USING (true);
CREATE POLICY "Public Delete Campaigns" ON public.campaigns FOR DELETE USING (true);

-- Enable Realtime for Live Admin Sync
ALTER PUBLICATION supabase_realtime ADD TABLE public.requests;
ALTER PUBLICATION supabase_realtime ADD TABLE public.campaigns;