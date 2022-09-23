# Nuclei

```bash
nuclei -ut # update templates
```

```bash
nuclei -u https://$ip -o nuclei
nuclei -u https://$subdomain.$domain -me nuclei # markdown exported
```

```bash
nuclei -rf -u https://$ip -o nuclei # force all redirects
```