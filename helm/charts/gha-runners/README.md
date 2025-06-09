# GitHub Actions Runner Helm Chart

This Helm chart deploys GitHub Actions Runners in multiple modes:

- `runner`: Single Pod runner  
- `runnerDeployment`: Scalable runner deployment  
- `runnerSet`: Fully managed runner set  
- Optional: `horizontalRunnerAutoscaler` for dynamic scaling

Enable the desired modes with:
- `--set deployRunnerDeployment=true`
- `--set deployRunnerSet=true`
- `--set deployHorizontalRunnerAutoscaler=true`

## Example Installation

```bash
helm install runner ./github-actions-runner --set deployRunner=true
```
