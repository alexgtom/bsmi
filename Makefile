default: cucumber

seed:
	rake db:schema:load db:seed

prep:
	rake db:migrate db:test:prepare db:seed

cucumber: prep
	rake cucumber
	
spec: prep
	rake spec
