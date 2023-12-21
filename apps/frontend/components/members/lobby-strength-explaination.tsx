import { Button } from "../ui/button";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from "../ui/dialog";

export default function LobbyStrengthExplaination() {
  return (
    <Dialog>
    <DialogTrigger asChild>
      <Button variant="secondary" className="rounded-full text-xs">How to interpret the influence level?</Button>
    </DialogTrigger>
    <DialogContent className="max-h-[90vh] overflow-auto">
      <DialogHeader>
        <DialogTitle>Wirksame und weniger wirksame Lobbys</DialogTitle>
        <DialogDescription>
          Die Intensität der Farbe gibt an, wie stark der Einfluss der Lobbyorganisationen ist
        </DialogDescription>
      </DialogHeader>
      <div className="prose text-primary overflow-auto py-4 ">
        <p>Für den Einflussfaktor «<span className="font-bold">hoch</span>», muss die Lobbyorganisation</p>
          <ul>
          <li>immer oder punktuell an Gesetzesrevisionen mitarbeiten (Vernehmlassungen);</li>
          <li>im Parlament mit einer Person vertreten sein, die im Verband, in der Organisation et cetera eine Führungsaufgabe wahrnimmt (Geschäftsleitung, Verwaltungsrat, Stiftungsrat);</li>
          <li>mit ihrem Parlamentsmitglied in der behandelnden Kommission (z.B. Gesundheitskommission) vertreten sein.</li>
        </ul>

        <p>Für den Einflussfaktor «<span className="font-bold">mittel</span>» muss die Lobbyorganisation</p>

        <ul>
        <li>punktuell an Gesetzesrevisionen mitarbeiten (Vernehmlassungen);</li>
        <li>im Parlament mit einem Mitglied oder Beirat (Patronatskomitee et cetera) vertreten sein.</li>
        </ul>

        <p>Für den Einflussfaktor «<span className="font-bold">gering</span>» muss die Lobbyorganisation</p>

        <ul>
        <li>nie an Gesetzesrevisionen mitarbeiten (Vernehmlassungen);</li>
        <li>im Parlament mit einer Person vertreten sein.</li>
        </ul>
      </div>
    </DialogContent>
  </Dialog>
  )
}
