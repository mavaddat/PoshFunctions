# todo write pester for Write-SelectStatement

Describe "[FN] Tests" {

    It "Number" {
        Test-Set | Should -Be 15
    }

    It "Boolean" {
        Test-Set | Should -BeTrue
    }

    It "Pipeline" {
        "data" | Test-Set | Should -Be 'Hello'
    }

}

