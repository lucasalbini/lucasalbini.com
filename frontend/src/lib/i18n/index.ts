import pt from "./pt.json";
import en from "./en.json";

const dictionaries = { pt, en };

export type Locale = keyof typeof dictionaries;

export function getDictionary(locale: Locale = "pt") {
  return dictionaries[locale] || dictionaries.pt;
}
