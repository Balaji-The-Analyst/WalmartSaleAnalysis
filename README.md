# Walmart_Analysis
This project aims to explore the Walmart Sales data to understand top performing branches and products, sales trend of of different products, customer behaviour. The aims is to study how sales strategies can be improved and optimized.
The major aim of thie project is to gain insight into the sales data of Walmart to understand the different factors that affect sales of the different branches.

## Here are the questions I was interested in answering
1) How does the distribution of sales across different product lines vary among branches, and which product lines exhibit the highest and lowest sales performance?
2) Is there a correlation between the time of day of purchases and customer ratings? Does this vary significantly across different branches?
3) Which branches have the highest and lowest ratings, and what strategies could branch B implement to improve its rating?
4) Are there specific days of the week that consistently yield higher customer ratings, and how does this trend vary across branches?
5) How does the sales volume fluctuate throughout the day, and are there specific time periods that experience higher sales across branches?

## I took the following steps to create my analysis
1) Utilized SQL's `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`, and `LIMIT` clauses for data selection, filtering, grouping, sorting, and limiting results respectively.
2) Employed aggregation functions like `SUM`, `AVG`, and `COUNT` along with GROUP BY to analyze sales data and derive insights on product performance and customer behavior.
3) Leveraged Common Table Expressions (`CTEs`) to simplify complex queries and enhance query readability.
4) Applied functions such as `to_char()` and `round()` for data transformation and formatting, ensuring clarity and presentation of analysis results.
5) Utilized SQL `window functions` for analyzing time-based trends and patterns in sales data.

## Here are my key takeaways
1) Gender per branch is more or less the same hence, I don't think has an effect of the sales per branch and other factors.
2) Looks like time of the day does not really affect the rating, its more or less the same rating each time of the day.
3) Branch A and C are doing well in ratings, branch B needs to do a  little more to get better ratings.
4) Mon, Tue and Friday are the top best days for good ratings.
5) Evenings experience most sales, the stores are filled during the evening hours.

