interface PageHeaderProps {
  heading: string | React.ReactNode
  text?: string | React.ReactNode
  children?: React.ReactNode
}

export function PageHeader({ heading, text, children }: PageHeaderProps) {
  return (
    <div className="flex items-center justify-between px-2">
      <div className="grid gap-1">
        <h1 className="font-heading text-3xl md:text-4xl">{heading}</h1>
        {text && <div className="text-lg text-muted-foreground">{text}</div>}
      </div>
      {children}
    </div>
  )
}
