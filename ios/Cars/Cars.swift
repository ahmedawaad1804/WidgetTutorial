//
//  Cars.swift
//  Cars
//
//  Created by Ahmed Awaad on 20/10/2023.
//

import WidgetKit
import SwiftUI
import Intents

struct WidgetData: Decodable {
  let sharedText: String
}

func defaultData() -> WidgetData {
  return  WidgetData(sharedText: "default data")
   }


struct Provider: IntentTimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), configuration: ConfigurationIntent(),data: defaultData())
  }
  
  func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date(), configuration: configuration,data: defaultData())
    completion(entry)
  }
  
  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = []
    let userDefaults = UserDefaults.init(suiteName: "group.cars.shared")
    if userDefaults != nil {
      let entryDate = Date()
      if let savedData = userDefaults!.value(forKey: "myWidgetKey") as? String {
        let decoder = JSONDecoder()
        let data = savedData.data(using: .utf8)
        if let parsedData = try? decoder.decode(WidgetData.self, from: data!) {
          let nextRefresh = Calendar.current.date(byAdding: .second, value: 5, to: entryDate)!
          let entry = SimpleEntry(date: nextRefresh, configuration: configuration, data: parsedData)
          let timeline = Timeline(entries: [entry], policy: .atEnd)
          completion(timeline)
        } else {
          print("Could not parse data")
        }
      } else {
        let nextRefresh = Calendar.current.date(byAdding: .second, value: 5, to: entryDate)!
        let entry = SimpleEntry(date: nextRefresh, configuration: configuration,data: defaultData())
        let timeline = Timeline(entries: [entry], policy: .never)
        
        
        completion(timeline)
        
      }
    }
  }
}
  struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let data: WidgetData
  }
  
  struct CarsEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
      Text(entry.data.sharedText)
    }
  }
  
  struct Cars: Widget {
    let kind: String = "Cars"
    
    var body: some WidgetConfiguration {
      IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
        CarsEntryView(entry: entry)
      }
      .configurationDisplayName("My Widget")
      .description("This is an example widget.")
    }
  }
  
  struct Cars_Previews: PreviewProvider {
    static var previews: some View {
      CarsEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(),data: defaultData()))
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
  }

