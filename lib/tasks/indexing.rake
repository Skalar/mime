namespace :mime do
  namespace :solr do
    desc "Re-index all models in Solr"
    task :reindex => :environment do
      puts "Clearing indices"
      Article.remove_all_from_index
      puts "Re-indexing articles. Each dot is 100 articles staged for re-indexing"
      per_batch = 100
      0.step(Article.count, per_batch) do |offset|
        Article.limit(per_batch).skip(offset).each { |article| article.index }
        print '.' # per 100 articles
      end
      puts "\n#{Article.count} articles reindex"
      puts "Commiting to Solr"
      Sunspot.commit
    end
  end
end
