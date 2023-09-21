output "IPRanges" {

  value = split(",", data.external.IPAlloction.result.IPRANGES)
  description = "The allocated IP ranges by this module"
  
  depends_on = [ 
    # the allocation needs to finished first
    # otherwise the the result will be NULL
    null_resource.IPAlloc 
  ]

}