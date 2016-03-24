module Jekyll
  class PodcastPlayerPage < Page
    def initialize(site, base, dir, post)
      @site = site
      @base = base
      @dir  = dir
      @name = post.basename.sub!('episode','player')

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'player.html')

      self.data['title'] = post.data['title']
      self.data['author'] = post.data['author']
      self.data['explicit'] = post.data['explicit']
      self.data['audio'] = post.data['audio']
      self.data['chapters'] = post.data['chapters']
    end
  end

  class PodcastPlayerPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'player'
        site.posts.docs.each do |post|
          dir =  site.config['players_dir'] || 'players'
          site.posts.docs.each do |post|
            player = PodcastPlayerPage.new(site, site.source, dir, post)
            player.write('/')
            site.pages << player
          end
        end
      end
    end
  end
end
