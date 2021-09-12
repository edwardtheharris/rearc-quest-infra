package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

// An example of how to test the Terraform module in examples/terraform-aws-network-example using Terratest.
func TestTerraformAwsNetworkExample(t *testing.T) {
	t.Parallel()

	// Pick a random AWS region to test in. This helps ensure your code works in all regions.
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)

	// Give the VPC and the subnets correct CIDRs
	vpcCidr := "172.32.0.0/16"
	subnetACidr := "172.32.16.0/20"
	subnetBCidr := "172.32.32.0/20"
	subnetCCidr := "172.32.48.0/20"
	subnetDCidr := "172.32.64.0/20"

	// Construct the terraform options with default retryable errors to handle the most common retryable errors in
	// terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"vpc_cidr":      vpcCidr,
			"subnet_a_cidr": subnetACidr,
			"subnet_b_cidr": subnetBCidr,
			"subnet_c_cidr": subnetCCidr,
			"subnet_d_cidr": subnetDCidr,
			"aws_region":    awsRegion,
		},
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	subnetAId := terraform.Output(t, terraformOptions, "subnet_a_id")
	subnetBId := terraform.Output(t, terraformOptions, "subnet_b_id")
	subnetCId := terraform.Output(t, terraformOptions, "subnet_c_id")
	subnetDId := terraform.Output(t, terraformOptions, "subnet_d_id")
	vpcId := terraform.Output(t, terraformOptions, "vpc_id")

	subnets := aws.GetSubnetsForVpc(t, vpcId, awsRegion)

	require.Equal(t, 4, len(subnets))
	// Verify if the network that is supposed to be public is really public
	assert.True(t, aws.IsPublicSubnet(t, subnetAId, awsRegion))
	assert.True(t, aws.IsPublicSubnet(t, subnetBId, awsRegion))
	assert.True(t, aws.IsPublicSubnet(t, subnetCId, awsRegion))
	assert.True(t, aws.IsPublicSubnet(t, subnetDId, awsRegion))
}
