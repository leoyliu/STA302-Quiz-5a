# Set seed for reproducibility
set.seed(42)

# Generate random number of pages for each undergraduate independently
matt_pages <- sample(20:100, 100, replace = TRUE)
ash_pages <- sample(20:100, 100, replace = TRUE)
jacki_pages <- sample(20:100, 100, replace = TRUE)
rol_pages <- sample(20:100, 100, replace = TRUE)
mike_pages <- sample(20:100, 100, replace = TRUE)

# Create a data frame
reading_data <- data.frame(
  Day = 1:100,
  Matt = matt_pages,
  Ash = ash_pages,
  Jacki = jacki_pages,
  Rol = rol_pages,
  Mike = mike_pages
)

# Print the first few rows of the data frame
print(reading_data)

# Assuming 'reading_df' is the name of our data frame.

# Test 1: Verify the number of days (rows)
test_number_of_days <- nrow(reading_data) == 100

# Test 2: Check for the correct number of undergraduates (columns)
test_number_of_undergrads <- ncol(reading_data) == 6  # 5 undergraduates + 1 day column

# Test 3: Check for missing values
test_no_missing_values <- all(complete.cases(reading_data))

# Test 4: Ensure readings are within expected limits (e.g., 20 pages to 100 pages)
test_readings_range <- all(reading_data$Matt >= 20 & reading_data$Matt <= 100) &&
  all(reading_data$Ash >= 20 & reading_data$Ash <= 100) &&
  all(reading_data$Jacki >= 20 & reading_data$Jacki <= 100) &&
  all(reading_data$Rol >= 20 & reading_data$Rol <= 100) &&
  all(reading_data$Mike >= 20 & reading_data$Mike <= 100)

# Test 5: Verify the 'Day' column contains a sequence from 1 to 100
test_day_sequence <- identical(reading_data$Day, 1:100)

# Print the results
results <- list(
  test_number_of_days = test_number_of_days,
  test_number_of_undergrads = test_number_of_undergrads,
  test_no_missing_values = test_no_missing_values,
  test_readings_range = test_readings_range,
  test_day_sequence = test_day_sequence
)

print(results)

library(ggplot2)

# Convert data from wide to long format for plotting
reading_data_long <- tidyr::gather(reading_data, key = "Undergraduate", value = "Pages", -Day)

# Use ggplot2 to create a line plot
ggplot(reading_data_long, aes(x = Day, y = Pages, color = Undergraduate, group = Undergraduate)) +
  geom_line() +
  labs(title = "Number of Pages Read by Each Undergraduate Over 100 Days",
       x = "Day",
       y = "Number of Pages") +
  theme_minimal() +
  theme(legend.position = "bottom")