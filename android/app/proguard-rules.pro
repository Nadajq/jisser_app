-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider
# Keep all Stripe classes (including push provisioning)
-keep class com.stripe.android.** { *; }

# Ignore warnings for missing push provisioning classes
-dontwarn com.stripe.android.pushProvisioning.**

# Exclude specific classes that cause issues
-keep class com.stripe.android.pushProvisioning.PushProvisioningActivity { *; }
-keep class com.stripe.android.pushProvisioning.PushProvisioningActivityStarter { *; }
-keep class com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider { *; }