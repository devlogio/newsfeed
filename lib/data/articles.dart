import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsfeed/model/news_article.dart';

List<NewsArticle> breakingNews = [];

FirebaseFirestore db = FirebaseFirestore.instance;

Future<Map<String, List<NewsArticle>>> getNewsArticles() async {
  Map<String, List<NewsArticle>> newsArticles = {};

  await db.collection("news").get().then((event) {
    for (var doc in event.docs) {
      List<NewsArticle> articlesForTopic = [];
      for (var article in doc.data().values) {
        articlesForTopic.add(
          NewsArticle(
            doc.id,
            article['title'],
            article['author'],
            article['publishedDate'],
            article['imageURL'],
            article['articleURL'],
          ),
        );
      }
      newsArticles.putIfAbsent(doc.id, () => articlesForTopic);
    }
  });

  _setBreakingNews(newsArticles);
  return newsArticles;
}

void _setBreakingNews(Map<String, List<NewsArticle>> newsArticles) {
  breakingNews = [
    newsArticles['US']!.first,
    newsArticles['World']!.first,
    newsArticles['Business']!.first,
    newsArticles['Technology']!.first,
    newsArticles['Entertainment']!.first,
    newsArticles['Sports']!.first,
    newsArticles['Science']!.first,
    newsArticles['Health']!.first,
  ];
}

// final Map<String, List<NewsArticle>> newsArticles = {
//   "US": [
//     NewsArticle(
//       "Biden to host Trump at the White House on Wednesday",
//       "Alexandra Marquez",
//       "Nov. 9, 2024",
//       "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTWqnfGtM5_iocDYw-sdl5_rkfl33AFNoRFU6Yx97kNnYWyeR8-Qa5JgoEc-cKsOnbeuTSVJyVcfBKL1k1-MvT25Kk6AI7kwKSVWqkfI0KabQDSwQ",
//       "https://www.nbcnews.com/politics/white-house/biden-hosts-trump-white-house-transition-rcna179455",
//     ),
//     NewsArticle(
//       "Smoke Smell Hits NYC As Forecasters Warn Of ‘Critical’ Fire Conditions In The Northeast—Here’s What To Know",
//       "Ty Roush",
//       "Nov. 9, 2024",
//       "https://imageio.forbes.com/specials-images/imageserve/672f9f8f4c928decbcaef102/NYCEM/0x0.jpg?format=jpg&crop=847,477,x0,y1,safe&width=1440",
//       "https://www.forbes.com/sites/tylerroush/2024/11/09/wildfires-spread-in-new-jersey-as-forecasters-warn-of-critical-fire-conditions-in-the-northeast-heres-what-to-know/",
//     ),
//     NewsArticle(
//       "1 monkey recovered safely, 42 others remain on the run from South Carolina lab",
//       "",
//       "Nov. 9, 2024",
//       "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTLXQD3_m7OrIHQjtvINlZiT0gJQOlWEL-koQQvfppY3PovfzEyipzgYSCFK9x7yAN07BI0BlBKr-XocUdl8jqcXhG9raDFgoNgQLBY",
//       "https://apnews.com/article/escaped-rhesus-macaques-south-carolina-lab-72c87e1df76839e701de8668f5dd6aac",
//     ),
//     NewsArticle(
//       "Trump’s gains with Latinos could reshape American politics. Democrats are struggling to respond",
//       "Will Weissert & Adriana Gomez Licon",
//       "Nov. 9, 2024",
//       "https://dims.apnews.com/dims4/default/5f145e8/2147483647/strip/true/crop/2400x1350+0+0/resize/1440x810!/format/webp/quality/90/?url=https%3A%2F%2Fassets.apnews.com%2F33%2F7a%2F37a0c441dfd37805f9a59b9c3ff4%2Fa1b1ae46e2374117994929c25ead8652",
//       "https://apnews.com/article/hispanic-voters-trump-florida-texas-pennsylvania-democrats-3637d86dede99e36f35d725afabdcba1",
//     ),
//     NewsArticle(
//       "Anger over ‘street chaos’ fuels ouster of another blue-city mayor",
//       "Dustin Gardiner",
//       "Nov. 9, 2024",
//       "https://www.politico.com/dims4/default/be940b4/2147483647/strip/true/crop/8017x5345+0+0/resize/1260x840!/quality/90/?url=https%3A%2F%2Fstatic.politico.com%2Fae%2Fff%2F82aa15a54306b9dc050377448a34%2Fap24313102711571.jpg",
//       "https://www.politico.com/news/2024/11/09/san-francisco-london-breed-ouster-00188581",
//     ),
//   ],
//   "World": [
//     NewsArticle(
//       "Amsterdam Bars Protests After Antisemitic Attacks on Soccer Fans",
//       "Christopher F. Schuetze",
//       "Nov. 9, 2024",
//       "https://static01.nyt.com/images/2024/11/09/multimedia/09amsterdam-attacks-001-zxcv/09amsterdam-media-1-qfzb-superJumbo.jpg?quality=75&auto=webp",
//       "https://www.nytimes.com/2024/11/09/world/europe/amsterdam-israel-soccer-attacks.html",
//     ),
//     NewsArticle(
//       "Global boiling, mass flooding and Trump: 10 big talking points for Cop29",
//       "Robin McKie",
//       "Nov. 9, 2024",
//       "https://i.guim.co.uk/img/media/1f6d54db7230d27fc8b023f5d288fb51905f434b/0_45_5838_3503/master/5838.jpg?width=620&dpr=2&s=none&crop=none",
//       "https://www.theguardian.com/environment/2024/nov/09/global-boiling-mass-flooding-and-trump-10-big-talking-points-for-cop29",
//     ),
//     NewsArticle(
//       "World The Berlin Wall came down 35 years ago today. Fragments of the famous border still remain today.",
//       "Lucia Suarez Sang",
//       "Nov. 9, 2024",
//       "https://assets1.cbsnewsstatic.com/hub/i/r/2019/11/09/be0369d6-4114-4555-b32b-bd74ffc17795/thumbnail/1280x720/62fa2472609402cf4895fbda776afcb3/1108-cbsn-allenpizzeyberlinwall-1973720-640x360.jpg?v=c1d30b1df13c40bf65c6c1e6d9ac4ad7",
//       "https://www.cbsnews.com/news/berlin-wall-germany-anniversary-35-years-history/",
//     ),
//     NewsArticle(
//       "Around 70% of deaths in Gaza are women and children, says UN",
//       "Tim Lister",
//       "Nov. 9, 2024",
//       "https://media.cnn.com/api/v1/images/stellar/prod/2024-11-07t090137z-777163166-rc2tzaajrqr4-rtrmadp-3-israel-palestinians-gaza.JPG?c=16x9&q=h_653,w_1160,c_fill/f_webp",
//       "https://www.cnn.com/2024/11/09/middleeast/un-warnings-gaza-humanitarian-conditions-intl/index.html",
//     ),
//     NewsArticle(
//       "'Life turned to dust': A family's grief after Spain floods",
//       "Nick Beake",
//       "Nov. 9, 2024",
//       "https://ichef.bbci.co.uk/news/1536/cpsprodpb/03ce/live/33ed6760-9e55-11ef-8624-97cfe8d39853.jpg.webp",
//       "https://www.bbc.com/news/articles/cyv7n95472go",
//     ),
//   ],
//   "Business": [
//     NewsArticle(
//       "Stocks soared on news of Trump's election. Bonds sank. Here's why.",
//       "Daniel de Visé",
//       "Nov. 9, 2024",
//       "https://www.usatoday.com/gcdn/authoring/authoring-images/2024/11/08/USAT/76136959007-usatsi-24707036.jpg?width=1320&height=918&fit=crop&format=pjpg&auto=webp",
//       "https://www.usatoday.com/story/money/2024/11/09/trump-win-bond-market/76137769007/",
//     ),
//     NewsArticle(
//       "This ‘Wall Street Girly’ Wants to Make Wealth More Accessible",
//       "Jenna Smialek",
//       "Nov. 9, 2024",
//       "https://static01.nyt.com/images/2024/10/21/multimedia/00DC-VIVIANTU-01-hqgz/00DC-VIVIANTU-01-hqgz-superJumbo.jpg?quality=75&auto=webp",
//       "https://www.nytimes.com/2024/11/09/business/vivian-tu-rich-af-personal-finance-tiktok-influencer.html",
//     ),
//     NewsArticle(
//       "Trump's win gives US stocks best week of the year",
//       "Suzanne O'Halloran",
//       "Nov. 9, 2024",
//       "https://a57.foxnews.com/static.foxbusiness.com/foxbusiness.com/content/uploads/2024/11/1440/810/donald-trump-8.jpg?ve=1&tl=1",
//       "https://www.foxbusiness.com/markets/trump-win-gives-u-s-stocks-best-week-year",
//     ),
//     NewsArticle(
//       "Why Bitcoin Will Soar Above Its Fresh Record: Van Straten",
//       "James Van Straten",
//       "Nov. 9, 2024",
//       "https://www.coindesk.com/resizer/rEu2OBHFP_hb7J-WDMnd-ptA3VQ=/1056x594/filters:quality(80):format(webp)/cloudfront-us-east-1.images.arcpublishing.com/coindesk/JDHHHKOQJZHHNJY4CFZ44QACSU.png",
//       "https://www.coindesk.com/markets/2024/11/09/why-bitcoin-will-soar-above-its-fresh-record-van-straten/",
//     ),
//     NewsArticle(
//       "Fed Cuts Interest Rates, But Inflation Remains Elephant In The Room",
//       "Surbhi Jain",
//       "Nov. 9, 2024",
//       "https://cdn.benzinga.com/files/images/story/2024/11/08/powell-fomc-ai2.png?optimize=medium&dpr=2&auto=webp&width=3840",
//       "https://www.benzinga.com/economics/macro-economic-events/24/11/41843182/fed-cuts-rates-but-inflation-remains-elephant-in-the-room",
//     ),
//   ],
//   "Technology": [
//     NewsArticle(
//       "Android 15 just made 2024's best phone even better",
//       "Nicholas Sutrich",
//       "Nov. 9, 2024",
//       "https://cdn.mos.cms.futurecdn.net/YiTras9m24ousRh2iB9KfK-1200-80.jpg.webp",
//       "https://www.androidcentral.com/phones/android-15-just-made-2024s-best-phone-even-better",
//     ),
//     NewsArticle(
//       "I Compared ChatGPT Search and Google, and Google Should Be Worried",
//       "David Nield",
//       "Nov. 8, 2024",
//       "https://lifehacker.com/imagery/articles/01JC5PXM2HCP6KQ32P8KYTW0A4/hero-image.fill.size_1248x702.v1731063631.jpg",
//       "https://lifehacker.com/tech/how-chatgpts-new-web-search-feature-compares-to-google-search",
//     ),
//     NewsArticle(
//       "Small Language Models Gaining Popularity While LLMs Still Go Strong",
//       "Lance Eliot",
//       "Nov. 8, 2024",
//       "https://imageio.forbes.com/specials-images/imageserve/672bd867fc3ad95dd4ddce3e/Woman-with-red-hair-looking-on-screen-of-her-mobile-phone-/0x0.jpg?format=jpg&crop=1221,914,x58,y0,safe&width=1440",
//       "https://www.forbes.com/sites/lanceeliot/2024/11/08/small-language-models-slm-gaining-popularity-while-large-language-models-llm-still-going-strong-and-reaching-for-the-stars/",
//     ),
//     NewsArticle(
//       "Upwind, an Israeli cloud cybersecurity startup, is raising \$100M at a \$850-900M valuation, say sources",
//       "Ingrid Lunden",
//       "Nov. 8, 2024",
//       "https://techcrunch.com/wp-content/uploads/2021/08/GettyImages-1273823720.jpg?resize=2048,1366",
//       "https://techcrunch.com/2024/11/08/upwind-an-israeli-cloud-cybersecurity-startup-is-raising-100m-at-a-850-900m-valuation-say-sources/",
//     ),
//     NewsArticle(
//       "Productivity hacks are overrated, says a16z VC who sold his own startup for \$1.25B",
//       "Julie Bort",
//       "Nov. 9, 2024",
//       "https://techcrunch.com/wp-content/uploads/2024/11/Martin-Casado-a16z-1.jpg",
//       "https://techcrunch.com/2024/11/09/productivity-hacks-are-overrated-says-a16z-vc-who-sold-his-own-startup-for-1-25b/",
//     ),
//   ],
//   "Entertainment": [
//     NewsArticle(
//       "'Candyman' star Tony Todd dies at 69",
//       "Chloe Veltman",
//       "Nov. 9, 2024",
//       "https://npr.brightspotcdn.com/dims3/default/strip/false/crop/4788x3150+0+0/resize/1100/quality/85/format/webp/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F71%2Ff9%2F5c94bc2e4d6c8ff039d1760ca931%2Fap110722131700.jpg",
//       "https://www.npr.org/2024/11/09/nx-s1-5185232/candyman-actor-tony-todd-dies",
//     ),
//     NewsArticle(
//       "Beyoncé passes Jay-Z in all-time Grammy nominations",
//       "Mark Savage",
//       "Nov. 9, 2024",
//       "https://ichef.bbci.co.uk/news/1536/cpsprodpb/a550/live/b99cf2b0-9def-11ef-828f-5bd3f69aa1a6.jpg.webp",
//       "https://www.bbc.com/news/articles/cx2lxd0kg8go",
//     ),
//     NewsArticle(
//       "‘Venom: The Last Dance’ \$14M, ‘Heretic’ & ‘Christmas Pageant’ \$10M+ Apiece In Post-Election Weekend At Box Office",
//       "Anthony D'Alessandro",
//       "Nov. 9, 2024",
//       "https://deadline.com/wp-content/uploads/2024/11/Heretic-Best-Christmas-Pageant-Ever-and-Venom-The-Last-Dance.jpg?w=681&h=383&crop=1",
//       "https://deadline.com/2024/11/box-office-heretic-best-christmas-pageant-ever-1236170937/",
//     ),
//     NewsArticle(
//       "4 Zodiac Signs Receive Blessings From The Universe On November 10, 2024",
//       "Ruby Miranda",
//       "Nov. 9, 2024",
//       "https://www.yourtango.com/sites/default/files/image_blog/2024-11/zodiac-signs-receive-blessings-universe-november-10-2024_0.png",
//       "https://www.yourtango.com/2024379489/zodiac-signs-receive-blessings-universe-november-10-2024",
//     ),
//     NewsArticle(
//       "A Timeline of Brianna \"Chickenfry\" LaPaglia and Zach Bryan's Breakup Drama",
//       "Natalie Finn",
//       "Nov. 9, 2024",
//       "https://akns-images.eonline.com/eol_images/Entire_Site/2024108/cr_1024x759-241108153629-Brianna_and_Zach_GettyImages-1986634282.jpg?fit=around%7C1024:759&output-quality=90&crop=1024:759;center,top",
//       "https://www.eonline.com/news/1409731/a-timeline-of-brianna-chickenfry-lapaglia-and-zach-bryans-breakup-drama",
//     ),
//   ],
//   "Sports": [
//     NewsArticle(
//       "College football picks, schedule: Predictions against the spread, odds for NCAA top 25 games in Week 11",
//       "David Cobb",
//       "Nov. 9, 2024",
//       "https://sportshub.cbsistatic.com/i/r/2024/11/08/b93e663c-19a3-4a00-b02f-b832f11691f1/thumbnail/770x433/19e3bc1ad9f9ba16b37663825353ad82/nussmeier.png",
//       "https://www.cbssports.com/college-football/news/college-football-picks-schedule-predictions-against-the-spread-odds-for-ncaa-top-25-games-in-week-11/",
//     ),
//     NewsArticle(
//       "Zion Williamson Out Indefinitely for Pelicans with Hamstring Injury",
//       "Adam Wells",
//       "Nov. 9, 2024",
//       "https://media.bleacherreport.com/image/upload/w_800,h_533,c_fill/v1731175104/lgc5ufasqerpcfjdnuwl.jpg",
//       "https://bleacherreport.com/articles/10142769-zion-williamson-out-indefinitely-for-pelicans-with-hamstring-injury",
//     ),
//     NewsArticle(
//       "UFC Fight Night 247 predictions: Plenty of unanimous picks in Las Vegas",
//       "Matt Erickson",
//       "Nov. 9, 2024",
//       "https://mmajunkie.usatoday.com/wp-content/uploads/sites/91/2024/11/UFC-Fight-Night-247-Staff-Picks-Thumb.jpg?w=1000&h=600&crop=1",
//       "https://mmajunkie.usatoday.com/2024/11/ufc-fight-night-247-las-vegas-neil-magny-vs-carlos-prates-predictions-picks-mma-betting",
//     ),
//     NewsArticle(
//       "Coco Gauff completes dream run to become youngest to win WTA Finals in 20 years",
//       "Issy Ronald & Kevin Dotson",
//       "Nov. 9, 2024",
//       "https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2183892888-copy.jpg?c=16x9&q=h_653,w_1160,c_fill/f_webp",
//       "https://www.cnn.com/2024/11/09/sport/coco-gauff-wta-finals-zheng-qinwen-spt-intl/index.html",
//     ),
//     NewsArticle(
//       "Warriors see Cavs using a familiar blueprint as they rewrite record books amid 10-0 start",
//       "Nate Ulrich",
//       "Nov. 9, 2024",
//       "https://www.beaconjournal.com/gcdn/authoring/authoring-images/2024/11/09/NABJ/76143720007-2183778626.jpeg?width=1320&height=880&fit=crop&format=pjpg&auto=webp",
//       "https://www.beaconjournal.com/story/sports/pro/cavs/2024/11/09/cleveland-cavaliers-10-0-start-kenny-atkinson-golden-state-warriors-stephen-curry-draymond-green/76135898007/",
//     ),
//   ],
//   "Science": [
//     NewsArticle(
//       "NASA astronauts won’t say which one of them got sick after almost 8 months in space",
//       "Marcia Dunn",
//       "Nov. 9, 2024",
//       "https://dims.apnews.com/dims4/default/683e181/2147483647/strip/true/crop/6669x3752+0+0/resize/1440x810!/format/webp/quality/90/?url=https%3A%2F%2Fassets.apnews.com%2Fd7%2Fcb%2Fc7e82802ddb40d180a76c9efaf85%2F482e1239eec443258cfe9c7ff05a8c1e",
//       "https://apnews.com/article/nasa-astronauts-international-space-station-496d91101f8305018beab93a194587a3",
//     ),
//     NewsArticle(
//       "On ancient Mars, carbon dioxide ice kept the water running. Here's how",
//       "Keith Cooper",
//       "Nov. 9, 2024",
//       "https://cdn.mos.cms.futurecdn.net/qa3chFod86ykUkBm3AqCk3-1067-80.jpg.webp",
//       "https://www.space.com/the-universe/mars/on-ancient-mars-carbon-dioxide-ice-kept-the-water-running-heres-how",
//     ),
//     NewsArticle(
//       "SpaceX Dragon fires thrusters to boost ISS orbit for the 1st time",
//       "Josh Dinner",
//       "Nov. 8, 2024",
//       "https://s.yimg.com/ny/api/res/1.2/8YyqNnhm8YOsQq_67EpOZg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTI0MDA7aD0xMzUwO2NmPXdlYnA-/https://media.zenfs.com/en/space_311/25664d0a2b1f86dc8f95b8fc4fc99043",
//       "https://www.yahoo.com/news/spacex-dragon-fires-thrusters-boost-184149957.html",
//     ),
//     NewsArticle(
//       "Next Ariane 6 launch slips to early 2025",
//       "Jeff Foust",
//       "Nov. 8, 2024",
//       "https://i0.wp.com/spacenews.com/wp-content/uploads/2024/07/a6-firstliftoff.jpg?w=1920&ssl=1",
//       "https://spacenews.com/next-ariane-6-launch-slips-to-early-2025/",
//     ),
//     NewsArticle(
//       "An object struck a satellite in Earth's orbit, leaving a hole",
//       "Mark Kaufman",
//       "Nov. 9, 2024",
//       "https://helios-i.mashable.com/imagery/articles/01OU0elHrhewHlNN1HvPoHK/hero-image.fill.size_1248x702.v1731081308.png",
//       "https://mashable.com/article/space-junk-meteoroid-satellite-impact-hole",
//     ),
//   ],
//   "Health": [
//     NewsArticle(
//       "Here are new guidelines for preventing stroke, the nation’s 4th biggest killer",
//       "Kenya Hunter",
//       "Nov. 9, 2024",
//       "https://dims.apnews.com/dims4/default/c132eae/2147483647/strip/true/crop/5214x3474+0+1/resize/980x653!/format/webp/quality/90/?url=https%3A%2F%2Fassets.apnews.com%2F70%2Fa5%2F5965ed4cd3c98260a23483f53b7c%2Fa835f2497c77452089efdac7d5fc63ae",
//       "https://apnews.com/article/stroke-risk-death-nutrition-exercise-ozempic-mounjaro-5fee3375b627377b6a39565ce2a647c5",
//     ),
//     NewsArticle(
//       "Bird flu begins its human spread, as health officials scramble to safeguard people and livestock",
//       "Carolyn Barber",
//       "Nov. 8, 2024",
//       "https://fortune.com/img-assets/wp-content/uploads/2024/11/GettyImages-842366656-e1731081964465.jpg?w=1440&q=75",
//       "https://fortune.com/well/2024/11/08/bird-flu-human-spreadsafeguard-people-livestock/",
//     ),
//     NewsArticle(
//       "AI Tool Reveals Long COVID May Affect 23% of People",
//       "MGB Communications",
//       "Nov. 9, 2024",
//       "https://neurosciencenews.com/files/2024/11/ai-long-covid-neuroscience.jpg.webp",
//       "https://neurosciencenews.com/ai-long-covid-28003/",
//     ),
//     NewsArticle(
//       "Cannabis can help some people – but not everyone – sleep",
//       "Hannah Harris Green",
//       "Nov. 9, 2024",
//       "https://i.guim.co.uk/img/media/0a7e2ebb4dc08d58d327ac3ba62bbc9aa89dda36/0_0_4400_2933/master/4400.jpg?width=620&dpr=2&s=none&crop=none",
//       "https://www.theguardian.com/us-news/2024/nov/09/cannabis-sleep-study",
//     ),
//     NewsArticle(
//       "Getting more light in the day and less at night is good for your health. Here's why",
//       "Will Stone",
//       "Nov. 8, 2024",
//       "https://npr.brightspotcdn.com/dims3/default/strip/false/crop/1565x1247+0+0/resize/1100/quality/85/format/webp/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F2c%2F8d%2Fa94ef44a4c8ba4987db28fccd004%2Fgettyimages-1363058111-1.jpg",
//       "https://www.npr.org/sections/shots-health-news/2024/11/07/nx-s1-5178149/light-exposure-circadian-rhythms-sleep",
//     ),
//   ],
// };
