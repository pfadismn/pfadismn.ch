it 'should display the homepage' do
  visit('/')
  click_link('Home')
  page.should have_selector('#mainContent > h2')
end

it 'should display ou' do
  visit('/')
  click_link('Abteilung')
  click_link('Wolfsstufe')
  page.should have_selector('html  > body > .container > .container > .container:nth-child(3) > h2')
end