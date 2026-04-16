import Foundation

enum WeatherMapper {
    static func map(response: WeatherResponseDTO, city: City) -> WeatherData {
        let current = CurrentWeather(
            temperature: response.current.temperature2m,
            windSpeed: response.current.windSpeed10m,
            weatherCode: response.current.weatherCode
        )

        let hourlyCount = min(response.hourly.time.count, response.hourly.temperature2m.count)
        var hourly: [HourlyForecast] = []
        hourly.reserveCapacity(hourlyCount)

        for index in 0..<hourlyCount {
            let time = response.hourly.time[index]
            let temperature = response.hourly.temperature2m[index]

            guard let date = makeHourlyDate(from: time) else { continue }
            hourly.append(HourlyForecast(date: date, temperature: temperature))
        }

        let dailyCount = min(
            response.daily.time.count,
            response.daily.temperature2mMin.count,
            response.daily.temperature2mMax.count
        )
        var daily: [DailyForecast] = []
        daily.reserveCapacity(dailyCount)

        for index in 0..<dailyCount {
            let dateString = response.daily.time[index]
            let minTemperature = response.daily.temperature2mMin[index]
            let maxTemperature = response.daily.temperature2mMax[index]

            guard let date = dailyDateFormatter.date(from: dateString) else { continue }
            daily.append(
                DailyForecast(
                    date: date,
                    minTemperature: minTemperature,
                    maxTemperature: maxTemperature
                )
            )
        }

        return WeatherData(city: city, current: current, hourly: hourly, daily: daily)
    }

    private static func makeHourlyDate(from string: String) -> Date? {
        iso8601DateFormatter.date(from: string) ?? fallbackHourlyFormatter.date(from: string)
    }

    private static let iso8601DateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()

    private static let fallbackHourlyFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        return formatter
    }()

    private static let dailyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
