#!/usr/bin/env bash
echo "Wp install"
runUser=$(stat -c '%u:%g' .)
alias wp='gosu $runUser wp'
if $(wp core is-installed); then
	current_site_url=$(wp option get siteurl)
	proto="$(echo "$current_site_url" | grep :// | sed -e's,^\(.*://\).*,\1,g')"
	new_site_url=$proto$VIRTUAL_HOST
	if [ "$current_site_url" != "$new_site_url" ]; then
		wp search-replace "$current_site_url" "$new_site_url"
	fi

  if [ -e post-install.sh ]; then
    gosu $runUser sh post-install.sh
  fi

fi
