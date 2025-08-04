# Visavo - Visa + Voyage

Visavo is an interactive web application that helps users determine where they can travel for tourism based on the documents they hold, such as passports, visas, OCI cards, PR cards, and more.

## 🌍 Features

- **Interactive 3D Globe**: Explore the world with a rotatable and zoomable 3D globe showing visa requirements
- **Document Management**: Securely store and manage your travel documents
- **Smart Logic**: Handles complex document combinations (e.g., US passport + India OCI card = visa-free to India)
- **Real-time Updates**: See travel requirements update as you add or remove documents
- **Privacy-First**: Never collects sensitive information like document numbers or personal details

## 🛡️ Privacy & Security

**We DO NOT collect:**
- Document numbers (passport number, alien #, visa ID)
- Date of birth
- Full legal name
- Gender, sexual orientation, etc.

**We ONLY collect:**
- Display name (user input)
- Email address
- Issuing country of document
- Document type (filtered list per country)
- Expiration date

## 🚀 Tech Stack

- **Frontend**: Next.js 15 (App Router), TypeScript, Tailwind CSS
- **3D Graphics**: Three.js, React Three Fiber
- **Authentication**: Supabase Auth
- **Database**: Supabase PostgreSQL
- **Forms**: React Hook Form with Zod validation
- **Icons**: Lucide React

## 📋 Prerequisites

- Node.js 18+ 
- npm or yarn
- Supabase account

## 🛠️ Setup Instructions

### 1. Clone the Repository

```bash
git clone <repository-url>
cd visavo
```

### 2. Install Dependencies

```bash
npm install
```

### 3. Set Up Supabase

1. Create a new project at [supabase.com](https://supabase.com)
2. Go to Settings > API to get your project URL and anon key
3. Create a `.env.local` file in the root directory:

```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 4. Set Up Database Tables

Run the following SQL in your Supabase SQL editor:

```sql
-- Create user_documents table
CREATE TABLE user_documents (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  issuing_country TEXT NOT NULL,
  document_type TEXT NOT NULL,
  expiration_date DATE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE user_documents ENABLE ROW LEVEL SECURITY;

-- Create policy to allow users to manage their own documents
CREATE POLICY "Users can manage their own documents" ON user_documents
  FOR ALL USING (auth.uid() = user_id);

-- Create index for better performance
CREATE INDEX idx_user_documents_user_id ON user_documents(user_id);
```

### 5. Configure Authentication

In your Supabase dashboard:

1. Go to Authentication > Settings
2. Configure your site URL (e.g., `http://localhost:3000` for development)
3. Add redirect URLs:
   - `http://localhost:3000/dashboard`
   - `http://localhost:3000/onboarding`
   - `http://localhost:3000/reset-password`

### 6. Run the Development Server

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) to view the application.

## 🎯 User Flow

1. **Sign Up**: Users create an account with email, password, and legal disclaimer acceptance
2. **Email Verification**: Users verify their email address
3. **Document Onboarding**: Users add their travel documents (passport, visas, etc.)
4. **Interactive Dashboard**: Users explore the 3D globe to see travel possibilities
5. **Country Details**: Click on countries to see detailed entry requirements

## 🌐 Travel Requirements Logic

The application includes a simplified but comprehensive database of travel requirements:

- **Visa-Free**: Green markers on the globe
- **Visa on Arrival/eVisa**: Yellow markers
- **Consulate Visa Required**: Red markers
- **Banned/Special Permission**: Black markers

### Special Cases

The system handles complex document combinations:
- US passport + India OCI card = Visa-free to India
- Multiple passports are evaluated for best travel options
- Document expiration dates are considered

## 🔧 Development

### Project Structure

```
visavo/
├── app/                    # Next.js App Router pages
│   ├── dashboard/         # Main application dashboard
│   ├── login/            # Authentication pages
│   ├── signup/
│   ├── onboarding/       # Document setup
│   └── forgot-password/
├── components/           # Reusable React components
│   └── Globe.tsx        # 3D interactive globe
├── lib/                 # Utility functions and configurations
│   ├── supabase.ts      # Supabase client
│   ├── types.ts         # TypeScript type definitions
│   ├── countries.ts     # Country data and document types
│   ├── travel-requirements.ts # Visa logic
│   └── utils.ts         # Helper functions
└── public/              # Static assets
```

### Key Components

- **Globe.tsx**: 3D interactive globe using Three.js
- **Dashboard**: Three-panel layout with documents, globe, and country details
- **Onboarding**: Multi-step document addition process
- **Authentication**: Complete auth flow with Supabase

## 🚀 Deployment

### Vercel (Recommended)

1. Push your code to GitHub
2. Connect your repository to Vercel
3. Add environment variables in Vercel dashboard
4. Deploy

### Environment Variables for Production

```env
NEXT_PUBLIC_SUPABASE_URL=your_production_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_production_supabase_anon_key
```

## 📝 License

This project is licensed under the MIT License.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## ⚠️ Disclaimer

Visavo is a travel exploration tool, not a visa processing app. The information provided is for reference only. Users should always verify travel requirements with official sources before traveling. Visavo is not a source of legal advice.

## 📞 Support

For support or questions, please open an issue in the GitHub repository.
