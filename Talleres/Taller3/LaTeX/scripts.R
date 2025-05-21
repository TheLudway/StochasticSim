x <- numeric()
s <- 1
n <- 0

while(n < 100 || s / sqrt(n) >= 0.01) {
  x <- c(x, rnorm(1))
  n <- length(x)
  s <- sd(x)
}

cat("Cantidad de Xi generados", n, "\n")
cat("Desviación estándar", round(s, 5), "\n")
cat("Error estándar S/sqrt(n)", round(s/sqrt(n), 5), "\n")


n <- 1000
x <- runif(n, -1, 1)
xmean <- mean(x)
S <- sd(x)
L <- xmean - 1.96 * S/sqrt(n)
U <- xmean + 1.96 * S/sqrt(n)
cat("El estimado es", xmean, "\n")
cat("95% está entre (", L, ", ", U, ") \n", sep="")

  
trials <- 200
n <- 1000
true_mean <- 0

results <- data.frame(
  sample_mean = numeric(trials),
  lower_bound = numeric(trials),
  upper_bound = numeric(trials),
  contains_mean = integer(trials)
)  

for (i in 1:trials){
  x <- runif(n, -1, 1)
  xmean <- mean(x)
  S <- sd(x)
  L <- xmean - 1.96 * S/sqrt(n)
  U <- xmean + 1.96 * S/sqrt(n)
  contains <- as.integer(L <= true_mean & true_mean <= U)
  
  results[i, ] <- c(xmean, L, U, contains)
}

cat("Número de intentos:", trials, "\n")

print(results, digits= 4)

porcentaje <- mean(results$contains_mean) * 100

cat("\n", porcentaje, "% de los intervalos de", 
    "confianza contienen la media real\n")

outcomes <- c(-10000, -5000, 5000)
probabilities <- c(0.25, 0.5, 0.25)

n <- 10^5 

X <- sample(outcomes, size = n , replace = TRUE, prob = probabilities)

length(X)

summary(X)

mean_estimates <- numeric(n)
lower_CI <- numeric(n)
upper_CI <- numeric(n)
ie <- 1.96 

for (j in 2:n) {
  x_sub <- X[1:j]
  mean_j <- mean(x_sub)
  sd_j <- sd(x_sub)
  se_j <- sd_j / sqrt(j)
  
  mean_estimates[j] <- mean_j
  lower_CI[j] <- mean_j - ie * se_j
  upper_CI[j] <- mean_j + ie * se_j
}

# Your plotting code remains the same
plot(2:n, mean_estimates[2:n], type = "l", col = "blue", lwd = 1,
     xlab = "j (tamaño de la submuestra)",
     ylab = "Ganancia esperada estimada",
     main = "Evolución de la media muestral y su IC del 95%")
lines(2:n, lower_CI[2:n], col = "red", lty = 2)
lines(2:n, upper_CI[2:n], col = "red", lty = 2)
abline(h = -3750, col = "darkgreen", lty = 3, lwd = 2)
legend("topright", legend = c("Media estimada", "IC 95%", "Valor real E[X]"),
       col = c("blue", "red", "darkgreen"), lty = c(1, 2, 3), bty = "n")

# Posibles valores de X
outcomes <- c(-10000, -5000, 5000)
probs_true <- c(0.25, 0.5, 0.25)

# Inicializar matrices para almacenar las estimaciones y CIs
p_estimates <- matrix(0, nrow = n, ncol = 3)
p_lower <- matrix(0, nrow = n, ncol = 3)
p_upper <- matrix(0, nrow = n, ncol = 3)

z <- 1.96  # Nivel de confianza del 95%

for (j in 2:n) {
  x_sub <- X[1:j]
  for (i in 1:3) {
    val <- outcomes[i]
    p_hat <- mean(x_sub == val)
    se <- sqrt(p_hat * (1 - p_hat) / j)
    
    p_estimates[j, i] <- p_hat
    p_lower[j, i] <- max(0, p_hat - z * se)
    p_upper[j, i] <- min(1, p_hat + z * se)
  }
}

colors <- c("blue", "orange", "purple")
labels <- c("p_X(-10000)", "p_X(-5000)", "p_X(5000)")
true_values <- c(0.25, 0.5, 0.25)

plot(2:n, p_estimates[2:n,1], type = "l", col = colors[1], ylim = c(0,1),
     xlab = "j (tamaño de la submuestra)", ylab = "Probabilidad estimada",
     main = "Estimación de $p_X(x)$ con ICs del 95%")

for (i in 1:3) {
  lines(2:n, p_estimates[2:n,i], col = colors[i], lwd = 1)
  lines(2:n, p_lower[2:n,i], col = colors[i], lty = 2)
  lines(2:n, p_upper[2:n,i], col = colors[i], lty = 2)
  abline(h = true_values[i], col = colors[i], lty = 3, lwd = 1.5)
}

legend("topright", legend = labels, col = colors, lty = 1:1, bty = "n")

# Leer el archivo
fat_data <- read.csv("body_fat.csv" )

# Histograma
hist(fat_data[[colnames(fat_data)[1]]],
     main = "Histograma del porcentaje de grasa corporal",
     xlab = "Body Fat (%)",
     col = "skyblue",
     border = "white")

# Estadísticas necesarias
media <- mean(fat_data[[colnames(fat_data)[1]]])
std <- sd(fat_data[[colnames(fat_data)[1]]])
n <- length(fat_data[[colnames(fat_data)[1]]])  

# Cálculo del error estándar
se <- std / sqrt(n)

# Intervalo de confianza del 95%
c <- 1.96
li <- media - c*se
ls <- media + c*se

# Mostrar resultado
cat(sprintf("The 95%% confidence interval for the mean is: [%.2f, %.2f]",
            li, ls))

original_data <- fat_data[[colnames(fat_data)[1]]]
n <- length(original_data)

# Generar 500 muestras bootstrap
bootstrap_samples <- replicate(500, sample(original_data, size = n,
                                           replace = TRUE), simplify = FALSE)

# Calcular la media de cada muestra bootstrap
bootstrap_means <- sapply(bootstrap_samples, mean)

# Histograma de las medias
hist(bootstrap_means,
     main = "Histograma de medias de muestras bootstrap",
     xlab = "Media del % de grasa corporal",
     col = "lightgreen",
     border = "white",
     probability = TRUE)  # Importante: escala el eje y para densidades

# Parámetros de la normal
mean_boot <- mean(bootstrap_means)
sd_boot <- sd(bootstrap_means)

# Añadir curva de distribución normal
curve(dnorm(x, mean = mean_boot, sd = sd_boot),
      col = "blue", lwd = 2, add = TRUE)

# Calcular intervalo de confianza bootstrap del 95%
bootstrap_ci <- quantile(bootstrap_means, probs = c(0.025, 0.975))


bootstrap_ci

reli_fun <- function(p1, p2, p3, p4){
  return (p1*p2*p3 + p1*p2*p4 + p1*p3*p4 + p2*p3*p4 - 3 * (p1 * p2 * p3 * p4))
}

reli_fun(0.9, 0.5, 0.2, 0.1)

# Given probabilities
p <- c(0.9, 0.5, 0.2, 0.1)

# Function to calculate system reliability for one trial
calculate_reliability <- function(p) {
  # Simulate the components as working (1) or failing (0) based on probabilities
  x <- rbinom(4, 1, p)
  
  # Apply the reliability function r(p) as given
  r <- sum(x[1]*x[2]*x[3]) + sum(x[1]*x[2]*x[4]) + sum(x[1]*x[3]*x[4]) +
    sum(x[2]*x[3]*x[4]) - 3 * prod(x)
  
  return(r)
}

# Function to run simulation for different number of realizations n
simulate_system_reliability <- function(n, p) {
  reliabilities <- numeric(n)
  
  for (i in 1:n) {
    reliabilities[i] <- calculate_reliability(p)
  }
  return(mean(reliabilities))
}

# Run simulation for each n: 10^2, 10^3, 10^4, 10^5 realizations
results <- sapply(c(10^2, 10^3, 10^4, 10^5),
                  function(n) simulate_system_reliability(n, p))

# View results
names(results) <- c("n=10^2", "n=10^3", "n=10^4", "n=10^5")
print(results)


simulate_system_reliability <- function(n, p) {
  reliabilities <- numeric(n)
  
  for (i in 1:n) {
    reliabilities[i] <- calculate_reliability(p)
  }
  
  sd_val <- sd(reliabilities)
  
  return(c(SD = sd_val))
}

results <- sapply(c(10^2, 10^3, 10^4, 10^5), function(n) simulate_system_reliability(n, p))
names(results) <- c("n=10^2", "n=10^3", "n=10^4", "n=10^5")

# Print results
print(results)

simulate_system_reliability <- function(n, p) {
  reliabilities <- numeric(n)
  for (i in 1:n) {
    reliabilities[i] <- calculate_reliability(p)
  }
  
  mean_val <- mean(reliabilities)
  sd_val <- sd(reliabilities)
  error_margin <- 1.96 * (sd_val / sqrt(n))  # 95% CI
  
  return(c(mean = mean_val,
           lower = mean_val - error_margin,
           upper = mean_val + error_margin))
}

# Run simulation for each n
results <- t(sapply(c(10^2, 10^3, 10^4, 10^5),
                    function(n) simulate_system_reliability(n, p)))

rownames(results) <- c("n=10^2", "n=10^3", "n=10^4", "n=10^5")

# Print result as a table
print(round(results, 5))

library(ggplot2)

# Lectura del dataset
loans_income <- read.csv("loans_income.csv")
loans_income <- loans_income[[colnames(loans_income)]]

# Tomar una muestra de una variable aleatoria simple. 
samp_data <- data.frame(income=sample(loans_income, 1000),
                        type = 'data_dist')

# Tomar una muestra de medias de 5 valores
samp_mean_05 <- data.frame(income = tapply(sample(loans_income, 1000*5),
                                           rep(1:1000, rep(5, 1000)), FUN=mean), type='mean_of_5')

# Tomar una muestra de medias de 20 valores 
samp_mean_20 <- data.frame(income = tapply(sample(loans_income, 1000*20),
                                           rep(1:1000, rep(20, 1000)), FUN=mean), type='mean_of_20')

# Unir los data frames y convertir la columna type como factor, es decir, 
# una categoría
income <- rbind(samp_data, samp_mean_05, samp_mean_20)
income$type = factor(income$type, levels=c('data_dist', 'mean_of_5',
                                           'mean_of_20'), labels=c('Data', 'Mean of 5', 'Mean of 20'))

# Graficar
ggplot(income, aes(x=income))+geom_histogram(bins=40)+facet_grid(type ~ .)


library(boot)
stat_fun <- function(x, idx) median(x[idx])
boot_obj <- boot(loans_income, R=1000, statistic=stat_fun)
boot_obj

set.seed(5)
set.seed(7)
sample20 <- sample(loans_income, 20)
sampleMean <- mean(sample20)

stat_fun <- function(x, idx) mean(x[idx])
boot_obj <- boot(sample20, R=500, statistic=stat_fun)
boot_ci <- boot.ci(boot_obj, conf=0.9, type='basic')
X <- data.frame(mean=boot_obj$t)
ci90 <- boot_ci$basic[4:5]
ci <- data.frame(ci=ci90, y=c(9, 11))
ci
ggplot(X, aes(x=mean)) +
  geom_histogram(bins=40, fill='#AAAAAA')+
  geom_vline(xintercept=sampleMean, linetype=2) +
  geom_path(aes(x=ci, y=10), data=ci, size=2) +
  geom_path(aes(x=ci90[1], y=y), data=ci, size=2) +
  geom_path(aes(x=ci90[2], y=y), data=ci, size=2) +
  annotate('text', x=sampleMean, y=20, label='Sample mean', size=6) +
  annotate('text', x=sampleMean, y=8, label='90% interval', size=6) +
  theme_bw() +
  labs(x = '', y='Counts')
