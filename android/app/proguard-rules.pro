# Keep all Razorpay SDK classes
-keep class com.razorpay.** { *; }

# Ignore missing Google Pay classes (optional, if using Razorpay GPay features)
-dontwarn com.google.android.apps.nbu.paisa.inapp.client.api.**

# Ignore missing ProGuard annotation classes
-dontwarn proguard.annotation.Keep
-dontwarn proguard.annotation.KeepClassMembers
