config.load_autoconfig()
config.source('nord.py')
c.auto_save.session = True
c.url.default_page = 'https://google.com'
c.url.searchengines = {'DEFAULT': 'https://google.com/search?q={}'}
c.url.start_pages = ['https://google.com']
