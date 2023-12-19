import HeaderGradient from "@/components/header-gradient"
import { MainNav } from "../../components/main-nav"
import { SiteFooter } from "../../components/site-footer"
import { navigationConfig } from "../../config/navigation"

interface AppLayoutProps {
  children?: React.ReactNode
}

export default async function AppLayout({ children }: AppLayoutProps) {
  return (
    <div className="flex min-h-screen flex-col space-y-6">
      <header className="sticky top-0 z-40 border-b bg-background">
        <div className="container flex h-16 items-center justify-between py-4">
          <MainNav items={navigationConfig.mainNav} />
        </div>
      </header>
      <div className="container grid flex-1 gap-12">
        <HeaderGradient />
        <main className="flex w-full flex-1 flex-col overflow-hidden">
          {children}
        </main>
      </div>
      <SiteFooter className="border-t" />
    </div>
  )
}
