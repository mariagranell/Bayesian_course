
#make sure you have the following packages installed for the course

install.packages('rjags')
install.packages('coda')
install.packages('boot')
install.packages('scales')

#if you are having problems installing a package soetimes adding this argument to the install.packages() function can help

install.packages('scales', repos='http://cran.us.r-project.org')

#NOTE
##if you see this message just type 'n' and hit enter
  There are binary versions available but the
  source versions are later:
       binary source needs_compilation
rlang   0.4.5  0.4.8              TRUE
scales  1.1.0  1.1.1             FALSE

Do you want to install from sources the package which needs compilation? (Yes/no/cancel) n

#this is because if you run a windows machine or mac you want the binary version, unless you have installation tools to decode the source versions. Type 'n' and let it get on with it :)

## once you have these packages installed you need to install JAGS. JAGS is NOT an R package in the usual sense and so must be downloaded and installed as you would for any other software

#you install JAGS from here...(cut and paste into google)

https://sourceforge.net/projects/mcmc-jags/files/JAGS/4.x/

#and then hit the green button 'download latest version' and follow the usual installation steps


##update R if necessary if the new 'rjags' and JAGS are not compatible with an older version of R...and then do it all over again :)


#then try this 

library(rjags)
library(boot)
library(coda)


sink("phi_transmission")
cat("
model{
phi ~ dbeta(1,1)
for(t in 1:3){
	y[t] ~ dbin((1-phi)^t, n[t])
	}
}
",fill=TRUE)
sink()


n=c(28,29,40)
y=c(26,25,31)


data=list(
y=y,
n=n
)
jm=jags.model("phi_transmission",n.adapt=1000, n.chains=4, data=data)
update(jm, n.iter=3000)
zm=coda.samples(jm,variable.names=c("phi"), n.iter=5000)
summary(zm)
plot(zm)

#you should get an output in the R console and also a plot (see attachment)

#DON'T PANIC if you don't understand the code above...we won't be using this format and you will get lots of templates and explanations to make the coding very easy. Just close your eyes, take a deep breath, and relax. Everything will be fine :)






