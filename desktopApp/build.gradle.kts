import org.jetbrains.compose.desktop.application.dsl.TargetFormat

plugins {
    id("org.jetbrains.kotlin.jvm")
    id("org.jetbrains.compose")
    id("org.jetbrains.kotlin.plugin.compose")
}

dependencies {
    implementation(compose.desktop.currentOs)
    implementation(compose.material3)
    implementation(compose.ui)
}

compose.desktop {
    application {
        mainClass = "com.oliverki3.desktop.MainKt"

        nativeDistributions {
            targetFormats(TargetFormat.Msi, TargetFormat.Exe)
            packageName = "OliverKi3"
            packageVersion = "1.0.0"
            description = "OliverKi3 Hello World"
            vendor = "OliverKi3"

            windows {
                menuGroup = "OliverKi3"
                upgradeUuid = "b3e2f1c4-8a5d-4e9f-b7c6-1d2e3f4a5b6c"
            }
        }
    }
}
