import type { InputHTMLAttributes } from "react";

type Props = InputHTMLAttributes<HTMLInputElement> & {
  name: string;
  label: string;
  hint?: string;
  error?: string;
};

/** Polje forme: natpis iznad, greška ispod, sve povezano za čitače ekrana. */
export function Field({ name, label, hint, error, ...input }: Props) {
  const id = `polje-${name}`;
  const opis = [hint ? `${id}-hint` : null, error ? `${id}-greska` : null].filter(Boolean).join(" ") || undefined;
  return (
    <div className="field">
      <label htmlFor={id}>{label}</label>
      <input id={id} name={name} aria-invalid={error ? true : undefined} aria-describedby={opis} {...input} />
      {hint && !error && (
        <span id={`${id}-hint`} className="field-hint">
          {hint}
        </span>
      )}
      {error && (
        <span id={`${id}-greska`} className="field-error" role="alert">
          {error}
        </span>
      )}
    </div>
  );
}
