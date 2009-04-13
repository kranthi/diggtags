require 'digg'
module DiggTags
  include Radiant::Taggable

  digg = Digg.new               # create a digg client
  
  tag 'digg' do |tag|
    tag.expand
  end
  
  tag 'digg:widget' do |tag|
    %{
      <script type="text/javascript">
          digg_id = 'digg-widget-container'; //make this id unique for each widget you put on a single page.
          digg_description = 1;
          digg_target = 1;
     </script>
     <script type="text/javascript" src="http://digg.com/tools/widgetjs"></script>
     <script type="text/javascript" src="http://digg.com/tools/services?type=javascript&callback=diggwb&endPoint=//stories/popular&count=20"></script>
     }
  end
  
  
  tag 'digg:each' do |tag|
    result =[]
    request_uri = '/stories/'+"#{tag.attr['category']}"
    count = tag.attr['count'] || 3
    digg.stories(request_uri, :count => count ).each do |story|
      tag.locals.story = story
      result << tag.expand
    end
    result
  end

  tag 'digg:each:story' do |tag|
    story = tag.locals.story
    %{
        <p>
          <img src ="#{story.user.icon}" /> 
          <a href="#{story.href}" title="#{story.title}">#{story.title}</a></p><p>"#{story.description}" 
       </p>
       <script type="text/javascript">
         digg_url = '#{story.href}';
         digg_bgcolor = '#ff9900';
         digg_skin = 'compact';
         digg_window = 'new';
      </script>
      <script src="http://digg.com/tools/diggthis.js" type="text/javascript"></script>

     }
    puts"---#{story}----"
  end
  

  tag 'digg:gallery' do |tag|

    result_photo = [] 
    digg.galleries('/galleryphotos', :count => 10).each do |photo|
      result_photo << "<img src='#{photo.src}'/>"
      result_photo << tag.expand
    end
      result_photo
  end

end
