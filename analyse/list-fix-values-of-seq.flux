default infile="prod/input/export_mab_hbz60.z9035.f.20250108.091329.seq";
default RECORDTYPE="ME";
default FIELD="001";

infile
| open-file
| as-lines
| decode-aseq
| merge-same-ids // combines the aseq statements in single records. 
| fix("if any_equal('FMT',$[RECORDTYPE])
				reject()
			end
",*)
| list-fix-values(FIELD, count="false")
| write(FLUX_DIR + "result.txt")
;