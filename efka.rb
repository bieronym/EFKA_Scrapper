require 'watir'
require 'pony'
require 'mime-types'
require 'roo'

data=Roo::Spreadsheet.open('./lista.xlsx')
username=data.column(1)
password=data.column(2)
amka=data.column(3)
email=data.column(4)
n_length=username.length
n_length=n_length-1
path=Dir.pwd
prefs = {
  download: {
    prompt_for_download: false,
    default_directory: path
  },
   plugins: {
    always_open_pdf_externally: true
  }
}
for i in 1..n_length do

  browser=Watir::Browser.new:chrome, options: {prefs: prefs}
  browser.goto "https://www.idika.org.gr/EfkaServices/Default.aspx"

  browser.div(:class=>'dxb').click
  browser.div(:class=>'dxb').click

  browser.text_field(:name=>'j_username').value = username[i]
  browser.text_field(:name=>'j_password').value = password[i]
  browser.button(:class=>["btn", "btn-primary", "submit-button"]).click
  sleep(1)

  if browser.div(:text=>'Αυθεντικοποίηση Χρήστη').present?
    browser.button(:class=>["btn", "btn-primary", "submit-button"]).click
  end
  browser.text_field(:name=>'ctl00$ContentPlaceHolder1$ASPxFormLayout1$ASPxFormLayout1_E1AMKA').value = amka[i]
  browser.div(:class=>'dxb').click
  sleep(1)


  browser.goto "https://www.idika.org.gr/EfkaServices/Application/Contributions.aspx"
  sleep(2)
  a=browser.span(:id => "ContentPlaceHolder1_panelEidop_mainFormLayout_labelAmmount").text
  tautotita=browser.span(:id => "ContentPlaceHolder1_panelEidop_mainFormLayout_labelRFcode").text

  browser.div(:class=>'dxb').click
  Dir[("#{path}/EFKAPAYMENT*.pdf")]
  sleep(5)
  browser.quit
  file=Dir["#{path}/EFKA*.pdf"]
  File.rename(file[0], "#{username[i]}.pdf")
  print username[i]
  print a
  print tautotita
  ofili=a.slice! " \u20AC"
  a = a.encode(Encoding::IBM737)
  tautotita = tautotita.encode(Encoding::IBM737)



  template = "<p>Αγαπητέ/τή,<br>
  σας ενημερώνουμε ότι έχει εκδοθεί το μηνιαίο Ειδοποιητήριο του ΕΦΚΑ. Η οφειλή σας ανέρχεται στα #{a} και η ταυτότητα πληρωμής είναι η #{tautotita}.</p>

  <p>Με εκτίμηση,<br>
  Ιερωνυμάκης Βασίλειος, MSc CFE,<br>
  Λογιστής,<br>
  Σαουνάτσου 26 Ρέθυμνο 74100,<br>
  email: info@ieronymakis.gr</p>"

  template = template.encode(Encoding::UTF_8)

    Pony.mail({
      :to => email[i],
      :from => 'email',
      :charset => 'UTF-8',
      :via => :smtp,
      :subject => 'Ειδοποιητήριο ΕΦΚΑ',
      :html_body => template,
      :attachments => {File.basename("#{path}/#{username[i]}.pdf") => File.read("#{path}/#{username[i]}.pdf", {:binmode => true})},
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
end

abort
