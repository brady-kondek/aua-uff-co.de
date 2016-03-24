module Jekyll
  class PodcastPlayerDocument < Document
     def initialize(path, post, relations = {})
      @site = relations[:site]
      @path = path
      @extname = File.extname(path)
      @collection = relations[:collection]
      @has_yaml_header = true
      categories_from_path(collection.relative_directory)

      data.default_proc = proc do |_, key|
        site.frontmatter_defaults.find(relative_path, collection.label, key)
      end

      self.data['layout'] = 'player'
      self.data['title'] = post.data['title']
      self.data['author'] = post.data['author']
      self.data['explicit'] = post.data['explicit']
      self.data['audio'] = post.data['audio']
      self.data['chapters'] = post.data['chapters']
      self.content = '{{ page | web_player:site }}'
      trigger_hooks(:post_init)
    end
  end

  class PodcastPlayerPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'player_template'
        site.posts.docs.each do |post|
          site.collections['players'].docs << PodcastPlayerDocument.new(site.collections['players'].collection_dir, post, { collection: 'players', site: site })
        end
      end
    end
  end
end
