# encoding: UTF-8
ou = {}
ou[:abteilung] = OrganisationalUnit.create!(name: 'Abteilung', responsible_function: 'al')
ou[:biberstufe] = OrganisationalUnit.create!(name: 'Biberstufe', caption: 'Die Pfadi St. Mauritius Nansen', motto: 'Immer däbii', responsible_function: 'stufenleiter', parent: ou[:abteilung])
ou[:wolfsstufe] = OrganisationalUnit.create!(name: 'Wolfsstufe', caption: 'Jungs und Mädchen von 7 bis 10', motto: 'Euses Bescht', responsible_function: 'stufenleiter', parent: ou[:abteilung])
ou[:pfadistufe] = OrganisationalUnit.create!(name: 'Pfadistufe', caption: 'Jungs und Mädchen von 10 bis 15', motto: 'Allzeit Bereit', responsible_function: 'stufenleiter', parent: ou[:abteilung])
ou[:piostufe] = OrganisationalUnit.create!(name: 'Piostufe', caption: 'Angehenden Leiter und Leiterinnen von 15 bis 17', motto: 'Zäme witercho', responsible_function: 'stufenleiter', parent: ou[:abteilung])
ou[:roverstufe] = OrganisationalUnit.create!(name: 'Roverstufe', caption: 'Leiter und Pfadis über 18', motto: 'Bewusst handeln', responsible_function: 'stufenleiter', parent: ou[:abteilung])
ou[:vampir] = OrganisationalUnit.create!(name: 'Vampir', responsible_function: 'gruppenleiter', parent: ou[:pfadistufe])
ou[:troja] = OrganisationalUnit.create!(name: 'Troja', responsible_function: 'gruppenleiter', parent: ou[:pfadistufe])
ou[:puma] = OrganisationalUnit.create!(name: 'Puma', responsible_function: 'gruppenleiter', parent: ou[:pfadistufe])
ou[:auriga] = OrganisationalUnit.create!(name: 'Auriga', responsible_function: 'gruppenleiter', parent: ou[:pfadistufe])
ou[:orion] = OrganisationalUnit.create!(name: 'Orion', responsible_function: 'gruppenleiter', parent: ou[:pfadistufe])
ou[:bubenwoelfe] = OrganisationalUnit.create!(name: 'Bubenwoelfe', responsible_function: 'gruppenleiter', parent: ou[:wolfsstufe])
ou[:maitliwoelfe] = OrganisationalUnit.create!(name: 'Maitliwoelfe', responsible_function: 'gruppenleiter', parent: ou[:wolfsstufe])

ou[:apv] = OrganisationalUnit.create!(name: 'APV', caption: 'Verein der Ehemaligen der Pfadi SMN', parent: ou[:abteilung])
ou[:elternrat] = OrganisationalUnit.create!(name: 'Elternrat', caption: 'Die Elternvertretung in der Pfadi SMN', parent: ou[:abteilung])


filou = Member.create!(first_name: 'Diego', last_name: 'Steiner', scout_name: 'Filou', email: 'filou@pfadismn.ch', birthdate: 23.years.ago, gender: 0, member_since: 14.years.ago, education: "Pano (2010)")
gulli = Member.create!(first_name: 'André', last_name: 'Bürkler', scout_name: 'Gulli', email: 'gulli@pfadismn.ch', birthdate: 24.years.ago, gender: 0, organisational_unit: ou[:abteilung])
Member.create!(first_name: 'Sonja', last_name: 'Janzek', scout_name: 'Shyra', email: 'shyra@pfadismn.ch', birthdate: 22.years.ago, gender: 0)
Member.create!(first_name: 'Sabine', last_name: 'Schibli', scout_name: 'Coco', email: 'coco@pfadismn.ch', birthdate: 24.years.ago, gender: 0)
Member.create!(first_name: 'Dominik', last_name: 'Näpfli', scout_name: 'Pippin', email: 'pippin@pfadismn.ch', birthdate: 19.years.ago, gender: 0)
Member.create!(first_name: 'Eva', last_name: 'Müller', scout_name: 'Chaja', email: 'chaja@pfadismn.ch', birthdate: 19.years.ago, gender: 0)

User.create!({email: 'filou@pfadismn.ch', password: '1234', password_confirmation: '1234', roles: [:admin], member: filou}, as: :admin)
User.create!({email: 'gulli@pfadismn.ch', password: 'defaultSMNpw', password_confirmation: 'defaultSMNpw', roles: [:admin], member: gulli}, as: :admin)
filou.reload
gulli.reload

News.create!(title: "Any News", body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", published_at: Time.now, creator: gulli.user)
News.create!(title: "Any News", body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", published_at: Time.now, creator: gulli.user)

address = {}
address[:holbrig] = Address.create!(line1: 'Kappenbühlstrasse 60', zip: '8049', place: 'Zürich', country: 'Schweiz')
address[:schuetzenhaus] = Address.create!(line1: 'Kappenbühlstrasse 80', zip: '8049', place: 'Zürich', country: 'Schweiz')
address[:lokal] = Address.create!(line1: 'Limattalstrasse 146', zip: '8049', place: 'Zürich', country: 'Schweiz')
address[:meierhofplatz] = Address.create!(line1: 'Limattalstrasse 177', zip: '8049', place: 'Zürich', country: 'Schweiz')
address[:landesmuseum] = Address.create!(line1: 'Museumsstrasse 2', zip: '8001', place: 'Zürich', country: 'Schweiz')

 places = {}
places[:holbrig] = Place.create!(address: address[:holbrig], name: 'Holbrig', description: 'Der Holbrig ist gleich beim Turnerhaus auf dem Hönggerberg und ist der übliche Treffpunkt für Aktivitäten im Wald.<h2>Koordinaten</h2>679/987//251/257', coordinates: '47.407604,8.497544')
places[:schuetzenhaus] = Place.create!(address: address[:schuetzenhaus], name: 'Schützenhaus', description: 'Das Schützenhaus Höngg ist der alternative Treffpunkt für Aktivitäten im Wald.<h2>Koordinaten</h2>679/883//251/529', coordinates: '47.409514,8.49672')
places[:lokal] = Place.create!(address: address[:lokal], name: 'Lokal', description: 'Unser Lokal befindet sich gleich beim Pfarreizentrum Heilig Geist. Treffpunkt ist der Eingang zu den Zivilschutz-Räumlichkeiten.<h2>Koordinaten</h2>680/345//250/599', coordinates: '47.401241,8.502817')
places[:meierhofplatz] = Place.create!(address: address[:holbrig], name: 'Meierhofplatz', description: 'Der Meierhofplatz ist der häufigste Treffpunkt für Aktivitäten in der Stadt. Genauer beschrieben trifft man sich vor dem Kiosk bei der 46er Haltestelle (Fahrtichtung Stadtzentrum).<h2>Koordinaten</h2>680/092//250/643', coordinates: '47.40181,8.499712')
places[:landesmuseum] = Place.create!(address: address[:landesmuseum], name: 'Landesmuseum', description: 'Der Platz vor dem Landesmuseum ist der übliche Treffpunkt für die Abreise in unvergessliche Lager.<h2>Koordinaten</h2>683/248//248/161', coordinates: '47.379004,8.540714')

Event.create!(organisational_unit: ou[:biberstufe], creator:filou.user, start_place: places[:holbrig], end_place: places[:lokal], start_time: DateTime.new(2012, 12, 22, 14, 00), end_time: DateTime.new(2012, 12, 22, 17, 30), name: 'Abschlussübung', description: 'Heute ist Abschlussübung von Pippin!', take_along:'Pfadihemd
  Kravatte
  Sackmesser', published_at: Time.now)
Event.create!(organisational_unit: ou[:wolfsstufe], creator:filou.user, start_place: places[:schuetzenhaus], end_place: places[:landesmuseum], start_time: DateTime.new(2012, 12, 22, 14, 00), end_time: DateTime.new(2012, 12, 22, 17, 30), name: 'Abschlussübung', description: 'Heute ist Abschlussübung von Grizzly', take_along:'Pfadihemd
  Kravatte 
  Sackmesser', published_at: Time.now)
Event.create!(organisational_unit: ou[:pfadistufe], creator:filou.user, start_place: places[:schuetzenhaus], end_place: places[:landesmuseum], start_time: DateTime.new(2012, 12, 22, 14, 00), end_time: DateTime.new(2012, 12, 22, 17, 30), name: 'Abschlussübung', description: 'Heute ist Abschlussübung von Grizzly', take_along:'Pfadihemd
  Kravatte
  Sackmesser', published_at: Time.now)
Event.create!(organisational_unit: ou[:roverstufe], creator:filou.user, start_place: places[:schuetzenhaus], end_place: places[:landesmuseum], start_time: DateTime.new(2012, 12, 22, 14, 00), end_time: DateTime.new(2012, 12, 22, 17, 30), name: 'Abschlussübung', description: 'Heute ist Abschlussübung von Grizzly', take_along:'Pfadihemd
  Kravatte
  Sackmesser', published_at: Time.now)
