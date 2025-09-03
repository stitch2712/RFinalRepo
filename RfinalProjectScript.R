#Loading all necessary packages:
library(here)
library(readr)
library(gtsummary)
library(ggplot2)

#Read in a dataset and save a file (can be data, table, figure, etc.):
data <- read.csv(here::here("/Users/suzain/Downloads/Food.csv"), sep = ",")

#Create a {gtsummary} table of descriptive statistics about your data:
tbl_summary(
	data,
	by = gender,
	include = c(city, restaurant_name, dish_name, category, payment_method, delivery_status ),
	label = list(
		city ~ "City",
		restaurant_name ~ "Restaurant Name",
		dish_name ~ "Name of the Dish",
		category ~ "Category",
		payment_method ~ "Payment Method",
		delivery_status ~ "Delivery Status"
	)
) |>
	add_p(test = list(
		all_continuous() ~ "t.test",
		all_categorical() ~ "chisq.test")) |>
	modify_caption("User Characteristics") |>
bold_labels() |>
	add_overall(col_label = "**Total**")

#Fit a regression and present well-formatted results from the regression:
linear_model <- lm(price ~ gender + category + payment_method, data = data)
tbl_regression(
	linear_model,
	label= list(
		gender ~ "Gender",
		category ~ "Category",
		payment_method ~ "Payment Method"
	)) |> bold_labels()


#Create a figure & Use the {here} package every time you refer to file paths:
figure <- ggplot(data,
								 aes(x = category,
								 		y = price, fill = category)) +
	theme_minimal() +
	geom_boxplot() +
	labs(x = "Food category",
			 y = "Price",
			 title = "Price distribution by Food category",
			 subtitle = "According to Kaggle")
figure
ggsave(here::here("outputs", "boxplot.png"), figure, width = 7, height = 5)

#Write and use a function that does something with the data:
avg_price <- function(df, group_var) {
	tapply(df$price, df[[group_var]], mean, na.rm = TRUE)
}
avg_price(data, "gender")

#Create and render a quarto document that includes stuff:

