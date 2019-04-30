# ΕΦΚΑ - Scrapper

Αυτοματοποιημένο κατέβασμα και αποστολή με email ειδοποιητηρίων του ΕΦΚΑ για Windows.

### Εγκατάσταση

Για την λειτουργία χρειάζεται να εγκατασταθεί η RUBY. (https://rubyinstaller.org/)
Στην συνέχεια θα πρέπει να εγκατασταθούν τα πακέτα:

```sh
gem install watir
gem install pony
gem install mime-types
gem install roo
```

Καθώς απαιτείτε και λήψη του ChromeDriver (http://chromedriver.chromium.org/downloads) και η καταχώρηση του στο Enviroment Path των Windows.

### Λειτουργία
#### Λίστα
Στο excel αρχείο με το όνομα lista.xlsx καταχωρούμε τα απαραίτητα στοιχεία.

| Username | Password | AMKA | Email |
| ------ | ------ |------ |------ |
#### Email
Για την αποστολή emails χρειαζόμαστε τα στοιχεία του SMTP Server όπου και τα τροποποιούμε στο αρχείο efka.rb στην γραμμή 83.
```sh

      :via_options => {
        :address              => "smpt.host",
        :port                 => '465',
        :user_name            => "username",
        :password             => "password",
        :openssl_verify_mode  => 'none',
        :ssl                  => true,
        :authentication       => :login, # :plain, :login, :cram_md5, no auth by default
        :domain               => "domain"
      }
    })
```
*Περισσότερα για το email (https://github.com/benprew/pony)
#### Μήνυμα
Για την αλλαγή του μηνύματος απλά αλλάζουμε το μήνυμα στην γραμμή 64 του αρχείου efka.rb

### Δημιουργία
  Ιερωνυμάκης Βασίλειος, MSc CFE,
  Λογιστής, Σαουνάτσου 26 Ρέθυμνο 74100,
  email: info@ieronymakis.gr
