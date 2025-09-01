import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("production") {
            dimension = "flavor-type"
            applicationId = "id.co.example.capsuleapps"
            resValue(type = "string", name = "app_name", value = "Capsule Apps")
        }
        create("staging") {
            dimension = "flavor-type"
            applicationId = "id.co.example.capsuleapps.staging"
            resValue(type = "string", name = "app_name", value = "[staging]Capsule Apps")
        }
        create("dev") {
            dimension = "flavor-type"
            applicationId = "id.co.example.capsuleapps.dev"
            resValue(type = "string", name = "app_name", value = "[dev]Capsule Apps")
        }
    }
}