import "./env.mjs"

/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  transpilePackages: ["@votebase/database"],
  output: "standalone",
  experimental: {
    serverComponentsExternalPackages: ["@prisma/client"],
   // outputFileTracingRoot: path.join(__dirname, "../../"),
  },
}

export default nextConfig
